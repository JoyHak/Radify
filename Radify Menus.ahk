#Requires AutoHotkey v2.0
#SingleInstance

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
            return
        } 
        
        try {
            Run(path)            
        } catch as e {
            Radify.OnError(e)
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
    return 'icons\kora\battery' idx '.png'
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
        ItemBackgroundImage: 'Skins\Minimal\ItemGlow0.png', 
        click: Sub(,[[schemes*]])
    }
}

; ── Menus ────────────────────────────────────────────────────────────────────────────────────────────────────────────

Radify.CreateMenu('main', [[
  {
    text: 'Folders',
    image: 'icons\PNG\folder small.png',
    ItemBackgroundImage: 'Skins\Minimal\ItemGlow2.png', 
    click: Sub(,[[
      {
        text: 'Docs',
        click: Dir('C:\Users\ToYu\Documents'),
        image: 'icons\Hemis\documents.ico'
      },
      {
        text: 'Downloads',
        click: Dir('C:\Users\ToYu\Downloads'),
        image: 'icons\Lumicons\System\User Downloads.ico'
      }
    ]]),
    rightClick: Sub(,[[
      {
        text: 'Links',
        image: 'icons\Lumicons\System\User Links.ico',
        click: Sub(,[[
          {
            text: 'Programs x86',
            click: Dir('C:\Program Files (x86)'),
            image: 'icons\PNG\windows orb2.png'
          },
          {
            text: 'Programs',
            click: Dir('C:\Program Files'),
            image: 'icons\PNG\windows orb.png'
          }
        ]])
      }
    ]])
  },
  {
    text: 'Apps',
    image: 'icons\PNG\performance monitor2.png',
    ItemBackgroundImage: 'Skins\Minimal\ItemGlow0.png',
    click: Sub(,[[
      {
        text: 'Theming',
        image: 'icons\PNG\window manager UI 2.png',
        ItemBackgroundImage: 'Skins\Minimal\ItemGlow0.png',
        click: Sub(,[[
          {
            text: 'MsStyleEditor',
            click: App('C:\Users\ToYu\msstyleEditor.exe'),
            image: 'icons\PNG\window manager UI 2.png'
          },
          {
            text: 'Winaero',
            click: App('C:\Program Files\Winaero Tweaker\WinaeroTweaker.exe'),
            image: 'icons\PNG\winaero.png'
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
        image: 'icons\3D graphics_png\icon edit scale ruby.png',
        ItemBackgroundImage: 'Skins\Minimal\ItemGlow0.png',
        click: Sub(,[[
          {
            text: 'Xyplorer',
            click: Dir('C:\Users\ToYu\XYplorer\Data\Icons'),
            image: 'icons\PNG\xyplorer small.png'
          },
          {
            text: 'icons',
            click: Dir('icons'),
            image: 'icons\3D graphics_png\icon edit scale ruby.png'
          }, 
          {
            text: 'FlatIcon',
            click: App('https://www.flaticon.com/search?word=performance&type=icon'),
            image: 'icons\PNG\flaticon.png'
          }
        ]])
      },
      {
        text: 'Monitoring',
        image: 'icons\PNG\performance monitor2.png',
        ItemBackgroundImage: 'Skins\Minimal\ItemGlow2.png',
        click: Sub(,[[
          {
            text: 'Spy',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Spy.lnk'),
            image: 'icons\PNG\anti_spyware.png'
          },
          {
            text: 'Autoruns',
            click: App('C:\Users\ToYu\SysinternalsSuite\Autoruns64.exe'),
            image: 'icons\PNG\clock_history4.png'
          },
          {
            text: 'Processes',
            click: App('C:\Users\ToYu\SysinternalsSuite\Procmon64.exe'),
            image: 'icons\PNG\utilities-energy-monitor.png'
          },
          {
            text: 'Explorer',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\System Informer.lnk'),
            image: 'icons\PNG\performance monitor2.png'
          },
          {
            text: 'RegEdit',
            click: App('C:\Users\ToYu\ooregeditor\OORegEdt.exe'),
            image: 'icons\PNG\registry blocks2.png'
          }
        ]])
      },
      {
        text: 'Drive',
        image: 'icons\PNG\drive partition defragment tree size.png',
        ItemBackgroundImage: 'Skins\Minimal\ItemGlow0.png',
        click: Sub(,[[
          {
            text: 'PerfectDisk',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PerfectDisk.lnk'),
            image: 'icons\PNG\drive defragmentation blocks.png'
          },
          {
            text: 'Clean',
            click: App('C:\Configs and settings\PowerShell\clean_system.ps1'),
            image: 'icons\PNG\clear drive.png'
          },
          {
            text: 'Uninstaller',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Revo Uninstaller Pro\Revo Uninstaller Pro.lnk'),
            image: 'icons\ICO\erase drive.ico'
          },
          {
            text: 'TreeSize',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TreeSize\TreeSize.lnk'),
            image: 'icons\PNG\drive partition defragment tree size.png'
          },
          {
            text: 'PrimoCache',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PrimoCache\PrimoCache.lnk'),
            image: 'icons\PNG\drive speed primo cache.png'
          }
        ]])
      }
    ]])
  },
  {
    text: 'Settings',
    image: 'icons\PNG\settings_gray.png',
    ItemBackgroundImage: 'Skins\Minimal\ItemGlow2.png', 
    click: Sub('lSet', [[
      {
        text: 'Settings',
        image: 'icons\PNG\settings_gray.png',
        ItemBackgroundImage: 'Skins\Minimal\ItemGlow0.png', 
        click: Sub(,[[
          {
            text: 'Settings',
            click: App('ms-settings:'),
            image: 'icons\PNG\settings_gray.png'
          }, 
          {
            text: 'Graphics',
            click: App('ms-settings:display-advancedgraphics'),
            image: 'icons\Antu (gradient)\network-card.ico'
          }
        ]])
      },      
      {
        text: 'Theme',
        image: 'icons\PNG\color-management.png',
        ItemBackgroundImage: 'Skins\Minimal\ItemGlow0.png', 
        click: Sub(,[[
          {
            text: 'Add theme',
            click: Dir('C:\Windows\Resources\Themes'),
            image: 'icons\PNG\folder colors small.png'
          },
          {
            text: 'Background',
            click: App('ms-settings:personalization-background'),
            image: 'icons\3D graphics_png\image-picture-viewer.png'
          },
          {
            text: 'Windows style',
            click: App('SystemPropertiesPerformance.exe'),
            image: 'icons\PNG\window manager UI 2.png'
          },
          {
            text: 'Change theme',
            click: App('ms-settings:themes'),
            image: 'icons\PNG\color-management.png'
          },
          {
            text: 'Trasparency',
            click: App('ms-settings:colors'),
            image: 'icons\PNG\transparency.png'
          }
        ]])
      }, 
      BatteryMenu('lSet', 'Power'),  ; switch power scheme
      {
        text: 'Restart explorer',
        click: Cmd.Bind('taskkill.exe /f /im explorer.exe & start explorer.exe'),
        image: 'icons\PNG\Explorer.png'
      }
    ]]), 
    rightClick: Sub(,[[
      {
        text: 'Shutdown timer',
        click: ShutdownMenu(),
        image: 'icons\PNG\clock_history4.png'
      },
      {
        text: 'OS boot',
        click: Cmd.Bind('shutdown.exe -r -o -f -t 0'),
        image: 'icons\McMuse\Dock Icon\boot.png'
      },
      { ; boot into/out safe mode
        text:  history.safeMode ? 'Normal boot' : 'Safe mode',
        click: SetSafeMode.Bind(history.safeMode ? 'exit' : 'default'),
        image: 'icons\Hemis\' . (history.safeMode ? 'warning2' : 'warning') . '.ico'
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