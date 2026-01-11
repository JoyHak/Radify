#Requires AutoHotkey v2.0
#SingleInstance

#Include .\Lib\Gdip_All.ahk
#Include Radify.ahk
Persistent
CoordMode('tooltip', 'screen')
TraySetIcon('images\radify0.ico',, true)

if (!pToken := Gdip_Startup()) {
    MsgBox('GDI+ failed to start. Please ensure you have GDI+ on your system.',, 'Iconx')
    ExitApp    
}

; ── Callbacks ────────────────────────────────────────────────────────────────────────────────────────────────────────

Dir(path, *) => Run.Bind(path, , , , )
App(path, *) => Run.Bind(path, , , , )
Cmd(cmd,  *) => Run.Bind(A_ComSpec ' /c ' cmd, , 'hide', , )

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

Dir(path, *) => Run.Bind(path, , , , )
App(path, *) => Run.Bind(path, , , , )

Image(path, menuId, itemText, image) {
    return (*) => (Run(path), Radify.SetItemImage(menuId, itemText, image))
}

Func.Prototype.DefineProp(
    '_', { Call: (
        (f, params*) => f.Bind(params*)
    )}
)

; ── Menus ────────────────────────────────────────────────────────────────────────────────────────────────────────────

Radify.CreateMenu('main', [[
  {
    text: 'Папки',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\folder small.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow2.png', 
    click: Sub(,[[
      {
        text: 'Доки',
        click: Dir('C:\Users\ToYu\Documents'),
        image: 'C:\Users\ToYu\Pictures\icons\Hemis\documents.ico'
      },
      {
        text: 'Загрузки',
        click: Dir('C:\Users\ToYu\Downloads'),
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\User Downloads.ico'
      },
      {
        text: 'Скрины',
        click: Dir('C:\Users\ToYu\Pictures\Screenshots'),
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\Mono\screenshot.ico'
      }
    ]]),
    rightClick: Sub(,[[
      {
        text: 'Ярлыки',
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\User Links.ico',
        click: Sub(,[[
          {
            text: 'Автозапуск',
            click: Dir('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\clock_history_3.png'
          },
          {
            text: 'Порты',
            click: Dir('C:\Users\ToYu'),
            image: 'C:\Users\ToYu\Pictures\icons\ICO\pack_archive_cube.ico'
          },
          {
            text: 'Ярлыки',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\User Links.ico'
          },
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
      },
      {
        text: 'Скрипты',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer file.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png', 
        click: Sub(,[[
          {
            text: 'Xyplorer',
            click: Dir('C:\Users\ToYu\XYplorer\Data\Scripts'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer file.png'
          },
          {
            text: 'PowerShell',
            click: Dir('C:\Configs and settings\PowerShell'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\console3.png'
          },
          {
            text: 'AutoHotKey',
            click: Dir('C:\Configs and settings\AutoHotKey'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\Mono\autohotkey.ico'
          }
        ]])
      }
    ]])
  },
  {
    text: 'Менеджеры',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer small.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow2.png', 
    click: Sub(,[[
      {
        text: 'Vivaldi',
        click: Dir('C:\Users\ToYu\AppData\Local\Vivaldi\Application\vivaldi.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\Vivaldi round.png'
      },
      {
        text: 'Xyplorer',
        click: Dir('C:\Users\ToYu\XYplorer\XYplorer.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer small.png'
      },
      {
        text: 'VPN',
        click: Dir('C:\Program Files\OpenVPN Connect\OpenVPNConnect.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\openVPN.png'
      },
      {
        text: 'Launcher',
        click: Dir('C:\Configs and settings\AutoHotKey\hotkeys\launcher.ahk'),
        image: 'C:\Users\ToYu\Pictures\icons\Fluent\png\recentmenu.png'
      }
    ]]), 
    rightClick: Sub(,[[
      {
        text: '3D',
        image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\cinema4d.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub(,[[
          {
            text: '3D projects',
            click: Dir('V:\Music\3D projects'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\Cinema 4D.png'
          },
          {
            text: 'c4d',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Maxon\Maxon Cinema 4D\Maxon Cinema 4D 2025.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\cinema4d.png'
          },
          {
            text: 'Sketchfab',
            click: Dir('https://sketchfab.com/search?features=downloadable&q=model&type=models'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\cubes\white cube.png'
          },
          {
            text: '3D models',
            click: Dir('V:\Music\3D models'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\cubes\white cube2.png'
          }
        ]])
      },
      {
        text: 'Picture',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\Adobe Photohop Eemet-10.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub(,[[
          {
            text: 'Pixlr',
            click: Dir('https://pixlr.com/ru/editor/'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\Adobe Photohop Eemet-10.png'
          },
          {
            text: 'Upscale',
            click: Dir('https://www.img2go.com/upscale-image'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\upscale.png'
          }
        ]])
      },
      {
        text: 'VFX',
        image: 'C:\Users\ToYu\Pictures\icons\clay_square\Adobe After Effects.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub(,[[
          {
            text: 'CapCut',
            click: Dir('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\CapCut\CapCut.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\McMuse\Dock Icon\capcut.png'
          },        
          {
            text: 'VFX projects',
            click: Dir('V:\Music\VFX projects'),
            image: 'C:\Users\ToYu\Pictures\icons\shrooms\PNG\AdobeAfterEffect.png'
          },
          {
            text: 'AfterFX',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Adobe After Effects 2024.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\clay_square\Adobe After Effects.png'
          },
        ]])
      },
/*
      {
        text: 'SFX',
        image: 'C:\Users\ToYu\Pictures\icons\ICO\sfx sound.ico',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub(, [[
        
        ]])
      }, 
*/
    ]])
  },
  {
    text: 'Кодинг',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\Notepad++.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow2.png', 
    click: Sub(,[[
      {
        text: 'Syncovery',
        click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Syncovery x64\Syncovery.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Sync Center.ico'
      },
      {
        text: 'Notepad++',
        click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Notepad++.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\Notepad++.png'
      },
      {
        text: 'GitButler',
        click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\GitButler\GitButler.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\gitbutler rounded2.png'
      }
    ]]), 
    rightClick: Sub(,[[
      {
        text: 'Релиз',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\github.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow2.png',
        click: Sub(,[[
          {
            text: 'Virus',
            click: Dir('https://www.virustotal.com/gui/file/1e1027e81d1a188daff3c95dfa787f2fea2f85b81c15f32c4cedba3c6fbdd38a/behavior'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Shield X.ico'
          },
          {
            text: 'Releases',
            click: Dir('C:\Configs and settings\AutoHotKey\QuickSwitch\Releases'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\zip rounded.png'
          },
          {
            text: 'GitHub',
            click: Dir('https://github.com/JoyHak/QuickSwitch/releases'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\github.png'
          },
          {
            text: 'Intezer',
            click: Dir('https://analyze.intezer.com/analyses/ed5d2df7-cf71-4aac-bea9-3011872f8492/dynamic-ttps'),
            image: 'C:\Users\ToYu\Pictures\icons\clay_square\CPU-Z.png'
          }
        ]])
      },
      {
        text: 'Менеджеры',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer small.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub(,[[
          {
            text: 'Explorer',
            click: Dir('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\explorer small.png'
          },
          {
            text: 'Xyplorer',
            click: Dir('C:\Users\ToYu\XYplorer\XYplorer.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer small.png'
          },
          {
            text: 'TotalCmd',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Total Commander\Total Commander 64 bit.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\totalcmd small.png'
          },
          {
            text: 'Dopus',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\GPSoftware\Directory Opus\Directory Opus.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\dopus small.png'
          },
        ]])
      },
      {
        text: 'Main',
        click: Dir('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\QuickSwitch.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\explorer small.png'
      },
      {
        text: 'Lib',
        click: Dir('C:\Configs and settings\AutoHotKey\QuickSwitch\Lib'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\pack_archive_cube.png'
      }
    ]])
  },
  {
    text: 'Приложения',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\performance monitor2.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
    click: Sub(,[[
      {
        text: 'Кастомизация',
        image: 'C:\Users\ToYu\Pictures\icons\ICO\window manager UI.ico',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub(,[[
          {
            text: 'MsStyleEditor',
            click: Dir('C:\Users\ToYu\msstyleEditor.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\ICO\window manager UI.ico'
          },
          {
            text: 'Win10',
            click: Dir('C:\Users\ToYu\Win 10 Tweaker.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\Fluent Individual Icons\apps\wine.ico'
          },
          {
            text: 'Winaero',
            click: Dir('C:\Program Files\Winaero Tweaker\WinaeroTweaker.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\winaero.png'
          },
          {
            text: 'Windhawk',
            click: Dir('C:\Program Files\Windhawk\windhawk.exe'),
            image: 'C:\Program Files\Windhawk\windhawk.exe'
          }
        ]])
      },
      {
        text: 'Иконки',
        image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\icon edit scale ruby.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub(,[[
          {
            text: 'Xyplorer',
            click: Dir('C:\Users\ToYu\XYplorer\Data\Icons'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\icon edit scale ruby 2.png'
          },
          {
            text: 'icons',
            click: Dir('C:\Users\ToYu\Pictures\icons'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\icon edit scale ruby.png'
          },
          {
            text: 'ResHacker',
            click: Dir('C:\Users\ToYu\Resource Hacker\ResourceHacker.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics\icon scale ruby edit 2.ico'
          },
          {
            text: 'FlatIcon',
            click: Dir('https://www.flaticon.com/search?word=performance&type=icon'),
            image: 'C:\Users\ToYu\Pictures\icons\Fluent Individual Icons\apps\rubyripper.ico'
          }
        ]])
      },
      {
        text: 'Наблюдение',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\performance monitor2.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow2.png',
        click: Sub(,[[
          {
            text: 'Spy',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Spy.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\anti_spyware.png'
          },
          {
            text: 'Autoruns',
            click: Dir('C:\Users\ToYu\SysinternalsSuite\Autoruns64.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\clock_history4.png'
          },
          {
            text: 'Processes',
            click: Dir('C:\Users\ToYu\SysinternalsSuite\Procmon64.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\utilities-energy-monitor.png'
          },
          {
            text: 'Explorer',
            click: Dir('C:\Users\ToYu\SysinternalsSuite\procexp64.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\performance monitor2.png'
          },
          {
            text: 'RegEdit',
            click: Dir('C:\Users\ToYu\ooregeditor\OORegEdt.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\registry blocks2.png'
          }
        ]]), 
        rightClick: Sub(,[[
          {
            text: 'Aida',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\FinalWire\AIDA64 Extreme\AIDA64 Extreme.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Setting Control Panel.ico'
          },
          {
            text: 'Устройства',
            click: Dir('C:\Users\ToYu\AppData\Local\Stardock\Start10Ctrlpnl\Диспетчер устройств.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Device Keyboard.ico'
          },
          {
            text: 'Диски',
            click: Dir('C:\Users\ToYu\AppData\Local\Stardock\Start10Ctrlpnl\Создание и форматирование разделов жесткого диска.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\kora\drive-harddisk.png'
          },
          {
            text: 'Панель',
            click: Dir('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Control Panel.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Fluent\png\gocontrolpanel.png'
          },
          {
            text: 'Службы',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\services.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Services.ico'
          },          
          {
            text: 'События',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Event Viewer.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Event Viewer.ico'
          }
        ]])
      },
      {
        text: 'Диск',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\drive partition defragment tree size.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub(,[[
          {
            text: 'PerfectDisk',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PerfectDisk.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\drive defragmentation blocks.png'
          },
          {
            text: 'Clean',
            click: Dir('C:\Configs and settings\PowerShell\clean_system.ps1'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\clear drive.png'
          },
          {
            text: 'Uninstaller',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Revo Uninstaller Pro\Revo Uninstaller Pro.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\ICO\erase drive.ico'
          },
          {
            text: 'TreeSize',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\TreeSize\TreeSize.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\drive partition defragment tree size.png'
          },
          {
            text: 'PrimoCache',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PrimoCache\PrimoCache.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\drive speed primo cache.png'
          }
        ]])
      }
    ]])
  },
  {
    text: 'Текст',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\console3.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
    click: Sub(,[[
      {
        text: 'Flow Launcher',
        click: Dir('C:\Users\ToYu\FlowLauncher\Flow.Launcher.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\flow launcher.png'
      },
      {
        text: 'Typora',
        click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Typora\Typora.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\typora2.png'
      },
      {
        text: 'CLion',
        click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\JetBrains\CLion 2024.1.5.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\clion.png'
      },
      {
        text: 'Warp',
        click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Warp.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\console3.png'
      },
    ]])
  },  
  {
    text: 'Настройки',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\settings_gray.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow2.png', 
    click: Sub(,[[
      {
        text: 'Настройки',
        click: Dir('ms-settings:'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\settings_gray.png'
      },
      {
        text: 'Сети',
        click: Dir('shell:::{7007ACC7-3202-11D1-AAD2-00805FC1270E}'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\settings_gray.png'
      },
      
    ]]),
    rightClick: Sub(,[[
      {
        text: 'Доки',
        click: Dir('C:\Users\ToYu\Documents'),
        image: 'C:\Users\ToYu\Pictures\icons\Hemis\documents.ico'
      }      
    ]])
  }, 
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
    
ToggleSuspend() {
    Suspend(-1)
    TraySetIcon(A_IsSuspended 
        ? 'images\radify0.ico' 
        : 'images\radify0.ico')
}

OnMessage(0x404, OnTrayClick)
OnMessage(1075,  (*) => Radify.Show('main'))
OnExit((*) => (Radify.DisposeResources(), Gdip_Shutdown(pToken)))

TraySetIcon('images\radify1.ico',, true)

HotIfWinExist('RadifyGui_0_0 ahk_class AutoHotkeyGUI')
Hotkey('Esc', (*) => WinClose(WinExist()))
HotIfWinExist()