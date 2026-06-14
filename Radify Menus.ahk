#Requires AutoHotkey v2.0
#SingleInstance

#Include .\Lib\Gdip_All.ahk
#Include Radify.ahk
#Include C:\Configs and settings\AutoHotKey\hotkeys\Lib\messages.ahk

Persistent
CoordMode('tooltip', 'screen')
TraySetIcon('images\radify0.ico',, true)

if (!pToken := Gdip_Startup()) {
    MsgBox('GDI+ failed to start. Please ensure you have GDI+ on your system.',, 'Iconx')
    ExitApp    
}

if (FileExist('History.json')) {
    _file := FileOpen('History.json', 'r', 'UTF-8')
    history := Json.Parse(_file.Read(), false, false)
    _file.Close()
} else {
    history := {
        safeMode: false, 
        shutdownTimer: false,
        powerScheme: '',
    }
}

; ── Callbacks ────────────────────────────────────────────────────────────────────────────────────────────────────────

Dir(path, *) => Run.Bind(path, , , , )
App(path, *) {
    return _Run.Bind(path)
    
    _Run(path) {        
        SplitPath(path, , , , &base)        
        if (hwnd := WinExist('ahk_exe ' base '.exe')) {
            WinShow(hwnd)
            WinActivate(hwnd)
        } else {
            Run(path)            
        }
    }
}
Cmd(cmd,  *) => Run(A_ComSpec ' /c ' cmd, , 'hide')

Image(path, menuId, itemText, image) {
    return (*) => (
        Run(path), 
        Radify.SetItemImage(menuId, itemText, image)
    )
}

Sub(name := '', params*) {
    if !name
        name := A_Now . Random(0, 10000) . params.length

    Radify.CreateMenu(name, params*)
    return Radify.Show.Bind(Radify, name, ) 
}

ShowTooltip(text, delayMs := 2000) {
	ToolTip(text)      
    SetTimer(ToolTip, -delayMs)
}

; ── Modes ────────────────────────────────────────────────────────────────────────────────────────────────────────────
    
ShutdownMenu(limit := 12) {
    m := Menu()
    m.Add('&Abort shutdown', Cmd.Bind('shutdown.exe -a'))
    m.Add()
    
    loop 12 {
        m.Add(
            '&' A_Index ' hours', 
            Cmd.Bind('shutdown.exe -s -f -t ' 3600 * A_Index)
        )
    }

    return (*) => m.Show()
}

SetSafeMode(mode := 'default') {
    history.safeMode := true
    
    switch mode, false {
        case 'default':
            vbs := 'SafeMode'            
        case 'net', 'network':
            vbs := 'SafeModeNetworking'
        case 'cmd', 'command', 'prompt':   
            vbs := 'SafeModeCommandPrompt'
        case 'exit', 'normal':
            vbs := 'SafeModeNormalMode'
            history.safeMode := false
        default:
            history.safeMode := false
            return Radify.ShowErrorMsg(A_ThisFunc ' - Unknown safe mode: "' mode '".')
    }

    Cmd('wscript.exe "C:\ProgramData\WinaeroTweaker\' vbs '.vbs"')
}

; ── Power Scheme ───────────────────────────────────────────────────────────────────────────────────────────────────

powerSchemes := [
  {
    id: '2b253980-fc5d-471a-8a6f-406a2315c9de', 
    text: 'Ultimate'
  },
  {
    id: '381b4222-f694-41f0-9685-ff5bb260df2e', 
    text: 'Balance'
  },
  {
    id: '4353a75f-5e8a-4572-99c8-2613c648674d', 
    text: 'Save'
  },
]

GetPowerImage(idx := 0) {    
    if (!idx && history.powerScheme) {
        for scheme in powerSchemes {
            if (scheme.id = history.powerScheme) {
                idx := A_Index
                break
            }    
        }
    }
    return 'C:\Users\ToYu\Pictures\icons\kora\battery' idx '.png'
}

SetPowerScheme(idx, menuId?, itemText?) {
    Cmd('powercfg.exe /SetActive ' powerSchemes[idx].id)
    history.powerScheme := powerSchemes[idx].id
    
    if (IsSet(menuId) && IsSet(itemText)) {        
        Radify.SetItemImage(
            menuId, 
            itemText, 
            GetPowerImage(idx)
        )
    }
}

BatteryMenu(parentMenuText, targetMenuText := 'Power') {    
    schemes := []
    for scheme in powerSchemes {
        schemes.push({
            text:  scheme.text,
            click: SetPowerScheme.Bind(A_Index, parentMenuText, targetMenuText), 
            image: GetPowerImage(A_Index), 
        })
    }
    
    return {
        text:  targetMenuText,
        image: GetPowerImage(),
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow0.png', 
        click: Sub(,[[schemes*]])
    }
}

; ── Menus ────────────────────────────────────────────────────────────────────────────────────────────────────────────

Radify.CreateMenu('main', [[
  {
    text: 'Folders',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\folder small.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow5.png', 
    click: Sub(,[[
      {
        text: 'Docs',
        click: Dir('C:\Users\ToYu\Documents'),
        image: 'C:\Users\ToYu\Pictures\icons\Hemis\documents.ico'
      },
      {
        text: 'Downloads',
        click: Dir('C:\Users\ToYu\Downloads'),
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\User Downloads.ico'
      }
    ]]),
    rightClick: Sub(,[[
      {
        text: 'Links',
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\User Links.ico',
        click: Sub(,[[
          {
            text: 'Programs x86',
            click: Dir('C:\Program Files (x86)'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\windows orb2.png'
          },
          {
            text: 'Programs',
            click: Dir('C:\Program Files'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\windows orb.png'
          }
        ]])
      }
    ]])
  },
  {
    text: 'Apps',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\performance monitor2.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow0.png',
    click: Sub(,[[
      {
        text: 'Theming',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\window manager UI 2.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow0.png',
        click: Sub(,[[
          {
            text: 'MsStyleEditor',
            click: App('C:\Users\ToYu\msstyleEditor.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\window manager UI 2.png'
          },
          {
            text: 'Winaero',
            click: App('C:\Program Files\Winaero Tweaker\WinaeroTweaker.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\winaero.png'
          },
          {
            text: 'Windhawk',
            click: App('C:\Program Files\Windhawk\windhawk.exe'),
            image: 'C:\Program Files\Windhawk\windhawk.exe'
          }
        ]])
      },
      {
        text: 'Icons',
        image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\icon edit scale ruby.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow0.png',
        click: Sub(,[[
          {
            text: 'Xyplorer',
            click: Dir('C:\Users\ToYu\XYplorer\Data\Icons'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer small.png'
          },
          {
            text: 'icons',
            click: Dir('C:\Users\ToYu\Pictures\icons'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\icon edit scale ruby.png'
          }, 
          {
            text: 'FlatIcon',
            click: App('https://www.flaticon.com/search?word=performance&type=icon'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\flaticon.png'
          }
        ]])
      },
      {
        text: 'Monitoring',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\performance monitor2.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow5.png',
        click: Sub(,[[
          {
            text: 'Spy',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Spy.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\anti_spyware.png'
          },
          {
            text: 'Autoruns',
            click: App('C:\Users\ToYu\SysinternalsSuite\Autoruns64.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\clock_history4.png'
          },
          {
            text: 'Processes',
            click: App('C:\Users\ToYu\SysinternalsSuite\Procmon64.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\utilities-energy-monitor.png'
          },
          {
            text: 'Explorer',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\System Informer.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\performance monitor2.png'
          },
          {
            text: 'RegEdit',
            click: App('C:\Users\ToYu\ooregeditor\OORegEdt.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\registry blocks2.png'
          }
        ]]), 
        rightClick: Sub(,[[
          {
            text: 'Aida',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\FinalWire\AIDA64 Extreme\AIDA64 Extreme.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Setting Control Panel.ico'
          },
          {
            text: 'Devices',
            click: App('C:\Users\ToYu\AppData\Local\Stardock\Start10Ctrlpnl\Диспетчер устройств.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Device Keyboard.ico'
          },
          {
            text: 'Drives',
            click: App('C:\Users\ToYu\AppData\Local\Stardock\Start10Ctrlpnl\Создание и форматирование разделов жесткого диска.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\kora\drive-harddisk.png'
          },
          {
            text: 'Control',
            click: App('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Control Panel.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Windows Icons\Control Panel.ico'
          },
          {
            text: 'Services',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\services.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Services.ico'
          },          
          {
            text: 'Events',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Event Viewer.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Event Viewer.ico'
          }
        ]])
      },
      {
        text: 'Drive',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\drive partition defragment tree size.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow0.png',
        click: Sub(,[[
          {
            text: 'PerfectDisk',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PerfectDisk.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\drive defragmentation blocks.png'
          },
          {
            text: 'Clean',
            click: App('C:\Configs and settings\PowerShell\clean_system.ps1'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\clear drive.png'
          },
          {
            text: 'Uninstaller',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Revo Uninstaller Pro\Revo Uninstaller Pro.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\ICO\erase drive.ico'
          },
          {
            text: 'TreeSize',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TreeSize\TreeSize.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\drive partition defragment tree size.png'
          },
          {
            text: 'PrimoCache',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PrimoCache\PrimoCache.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\drive speed primo cache.png'
          }
        ]])
      }
    ]])
  },
  {
    text: 'Settings',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\settings_gray.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow5.png', 
    click: Sub('lSet', [[
      {
        text: 'Settings',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\settings_gray.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow0.png', 
        click: Sub(,[[
          {
            text: 'Settings',
            click: App('ms-settings:'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\settings_gray.png'
          }, 
          {
            text: 'Graphics',
            click: App('ms-settings:display-advancedgraphics'),
            image: 'C:\Users\ToYu\Pictures\icons\Antu (gradient)\network-card.ico'
          }
        ]])
      },      
      {
        text: 'Theme',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\color-management.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow0.png', 
        click: Sub(,[[
          {
            text: 'Add theme',
            click: Dir('C:\Windows\Resources\Themes'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\folder colors small.png'
          },
          {
            text: 'Background',
            click: App('ms-settings:personalization-background'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\image-picture-viewer.png'
          },
          {
            text: 'Windows style',
            click: App('SystemPropertiesPerformance.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\window manager UI 2.png'
          },
          {
            text: 'Change theme',
            click: App('ms-settings:themes'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\color-management.png'
          },
          {
            text: 'Trasparency',
            click: App('ms-settings:colors'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\transparency.png'
          }
        ]])
      }, 
      BatteryMenu('lSet', 'Power'),  ; switch power scheme
      {
        text: 'Restart explorer',
        click: Cmd.Bind('taskkill.exe /f /im explorer.exe & start explorer.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\Explorer.png'
      }
    ]]), 
    rightClick: Sub(,[[
      {
        text: 'Shutdown timer',
        click: ShutdownMenu(),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\clock_history4.png'
      },
      {
        text: 'OS boot',
        click: Cmd.Bind('shutdown.exe -r -o -f -t 0'),
        image: 'C:\Users\ToYu\Pictures\icons\McMuse\Dock Icon\boot.png'
      },
      { ; boot into/out safe mode
        text:  history.safeMode ? 'Normal boot' : 'Safe mode',
        click: SetSafeMode.Bind(history.safeMode ? 'exit' : 'default'),
        image: 'C:\Users\ToYu\Pictures\icons\Hemis\' . (history.safeMode ? 'warning2' : 'warning') . '.ico'
      }
    ]])
  }
]])

; ── Tray ─────────────────────────────────────────────────────────────────────────────────────────────────────────────

trayMenu := [
  {
    text: 'Settings',
    image: 'images\settings.ico',
    click: (*) => Run('Radify Skin Editor.ahk'),
  },
  {
    text: 'Edit',
    image: 'images\edit-orange.ico',
    click: (*) => Edit(),
  },
  {
    text: 'Scripts',
    image: 'images\folder-orange.ico',
    click: (*) => Run(A_ScriptDir),
  },
  {
    text: 'Suspend',
    image: 'images\radify0.ico',
    click: (*) => ToggleSuspend(),
  },
  {
    text: 'Reload',
    image: 'images\reload-orange.ico',
    click: (*) => Reload(),
  },
  {
    text: 'Exit',
    image: 'images\exit-orange.ico',
    click: (*) => ExitApp(),
  },       
]


A_TrayMenu.Delete()
for item in trayMenu {
    A_TrayMenu.Add(item.text, item.click)
    A_TrayMenu.SetIcon(item.text, item.image)
}

OnTrayClick(wParam, lParam, uMsg, hWnd) {
    static WM_LBUTTONDOWN := 0x201

    if (lParam = WM_LBUTTONDOWN) {        
        Radify.Show('main')
    }
}

OnMenuExit(exitReason := 'exit', exitCode := 0) {   
    _history := Json.stringify(history)
    
    _file := FileOpen('History.json', 'w', 'UTF-8')
    _file.Write(_history)
    _file.Close()
    
    Radify.DisposeResources()
    Gdip_Shutdown(pToken)
}
    
ToggleSuspend() {
    Suspend(-1)
    TraySetIcon('images\radify' (!A_IsSuspended) '.ico')
}

OnMessage(0x404, OnTrayClick)
Hotkey("$LWin",  (*) => Radify.Show('main'))
OnExit(OnMenuExit)

TraySetIcon('images\radify1.ico',, true)
; ShowTooltip(A_ScriptName ' is initialized')