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

Sub(name, params*) => (Radify.CreateMenu(name, params*), Radify.Show.Bind(Radify, name, )) 
Dir(path, *) => Run.Bind(path, , , , )
App(path, *) => Run.Bind(path, , , , )

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
    click: Sub('лПапки', [[
      {
        text: 'Documents',
        click: Dir('C:\Users\ToYu\Documents'),
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\Note Grey.ico'
      },
      {
        text: 'Downloads',
        click: Dir('C:\Users\ToYu\Downloads'),
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\User Downloads.ico'
      },
      {
        text: 'Screenshots',
        click: Dir('C:\Users\ToYu\Pictures\Screenshots'),
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\Mono\screenshot.ico'
      }
    ]]),
    rightClick: Sub('рПапки', [[
      {
        text: 'Ярлыки',
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\User Links.ico',
        click: Sub('лЯрлыки', [[
          {
            text: 'Startup',
            click: Dir('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\clock_history_3.png'
          },
          {
            text: 'ToYu',
            click: Dir('C:\Users\ToYu'),
            image: 'C:\Users\ToYu\Pictures\icons\ICO\pack_archive_cube.ico'
          },
          {
            text: 'Programs',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\User Links.ico'
          },
          {
            text: 'Program Files (x86)',
            click: Dir('C:\Program Files (x86)'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\windows orb2.png'
          },
          {
            text: 'Program Files',
            click: Dir('C:\Program Files'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\windows orb.png'
          }
        ]])
      },
      {
        text: 'Скрипты',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer file.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png', 
        click: Sub('лСкрипты', [[
          {
            text: 'Scripts',
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
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png', 
    click: Sub('лМенеджеры', [[
      {
        text: 'Xyplorer',
        click: Dir('C:\Users\ToYu\XYplorer\XYplorer.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer small.png'
      },
      {
        text: 'Vivaldi',
        click: Dir('C:\Users\ToYu\AppData\Local\Vivaldi\Application\vivaldi.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\McMuse\Dock Icon\vivaldi.png'
      },
      {
        text: 'VPN',
        click: Dir('C:\Program Files\OpenVPN Connect\OpenVPNConnect.exe'),
        image: 'C:\Program Files\OpenVPN Connect\OpenVPNConnect.exe'
      },
      {
        text: 'Launcher',
        click: Dir('C:\Configs and settings\AutoHotKey\hotkeys\launcher.ahk'),
        image: 'C:\Users\ToYu\Pictures\icons\Fluent\png\recentmenu.png'
      }
    ]])
  },
  {
    text: 'Кодинг',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\Notepad++.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow2.png', 
    click: Sub('лКодинг', [[
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
    rightClick: Sub('рКодинг', [[
      {
        text: 'Релиз',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\github.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow2.png',
        click: Sub('лРелиз', [[
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
        click: Sub('лФМенеджеры', [[
          {
            text: 'Explorer',
            click: Dir('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\explorer small.png'
          },
          {
            text: 'Dopus',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\GPSoftware\Directory Opus\Directory Opus.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\dopus small.png'
          },
          {
            text: 'TotalCmd',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Total Commander\Total Commander 64 bit.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\totalcmd small.png'
          },
          {
            text: 'Xyplorer',
            click: Dir('C:\Users\ToYu\XYplorer\XYplorer.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer small.png'
          }
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
    click: Sub('лПриложения', [[
      {
        text: 'Кастомизация',
        image: 'C:\Users\ToYu\Pictures\icons\ICO\window manager UI.ico',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub('лКастомизация', [[
          {
            text: 'Win10',
            click: Dir('C:\Users\ToYu\Win 10 Tweaker.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\Fluent Individual Icons\apps\wine.ico'
          },
          {
            text: 'Winaero',
            click: Dir('C:\Program Files\Winaero Tweaker\WinaeroTweaker.exe'),
            image: 'C:\Program Files\Winaero Tweaker\WinaeroTweaker.exe'
          },
          {
            text: 'MsStyleEditor',
            click: Dir('C:\Users\ToYu\msstyleEditor.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\ICO\window manager UI.ico'
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
        click: Sub('лИконки', [[
          {
            text: 'XY icons',
            click: Dir('C:\Users\ToYu\XYplorer\Data\Icons'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\icon edit scale ruby 2.png'
          },
          {
            text: 'icons',
            click: Dir('C:\Users\ToYu\Pictures\icons'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\icon edit scale ruby.png'
          },
          {
            text: 'Resource Hacker',
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
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub('лНаблюдение', [[
          {
            text: 'Spy',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Spy.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\ICO\anti_spyware.ico'
          },
          {
            text: 'Autoruns',
            click: Dir('C:\Users\ToYu\SysinternalsSuite\Autoruns64.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\ICO\clock_history_3.ico'
          },
          {
            text: 'Explorer',
            click: Dir('C:\Users\ToYu\SysinternalsSuite\procexp64.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\performance monitor2.png'
          },
          {
            text: 'Processes',
            click: Dir('C:\Users\ToYu\SysinternalsSuite\Procmon64.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\Fluent Individual Icons\apps\utilities-energy-monitor.ico'
          },
          {
            text: 'RegEdit',
            click: Dir('C:\Users\ToYu\ooregeditor\OORegEdt.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\ICO\registry blocks2.ico'
          }
        ]])
      },
      {
        text: 'Диск',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\drive partition defragment tree size.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub('лДиск', [[
          {
            text: 'PerfectDisk',
            click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PerfectDisk.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\drive defragmentation blocks.png'
          },
          {
            text: 'clean_system.ps1',
            click: Dir('C:\Configs and settings\PowerShell\clean_system.ps1'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\clear drive.png'
          },
          {
            text: 'Revo Uninstaller Pro',
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
    click: Sub('лТекст', [[
      {
        text: 'Flow Launcher',
        click: Dir('C:\Users\ToYu\FlowLauncher\Flow.Launcher.exe'),
        image: 'C:\Users\ToYu\FlowLauncher\Flow.Launcher.exe'
      },
      {
        text: 'Typora',
        click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Typora\Typora.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\typora2.png'
      },
      {
        text: 'Warp',
        click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Warp.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\console3.png'
      },
      {
        text: 'CLion',
        click: Dir('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\JetBrains\CLion 2024.1.5.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\clion.png'
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

OnWmUser(wParam, lParam, uMsg, hWnd) {
    Radify.Show('main')
}
    
ToggleSuspend() {
    Suspend(-1)
    TraySetIcon(A_IsSuspended 
        ? 'images\radify0.ico' 
        : 'images\radify0.ico')
}

OnMessage(0x404, OnTrayClick)
OnMessage(1075,  OnWmUser)
OnExit((*) => (Radify.DisposeResources(), Gdip_Shutdown(pToken)))

TraySetIcon('images\radify1.ico',, true)

HotIfWinExist('RadifyGui_0_0 ahk_class AutoHotkeyGUI')
Hotkey('Esc', (*) => WinClose(WinExist()))
HotIfWinExist()