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
    
ShutdownMenu(limit := 12) {
    m := Menu()
    m.Add('&Abort shutdown', Cmd('shutdown.exe -a'))
    m.Add()
    
    loop limit {
        m.Add('&' A_Index ' hours', Cmd('shutdown.exe -s -f -t ' (3600 * A_Index)))
    }

    return (*) => m.Show()
}

safeMode := Radify.generals.safeMode
SetSafeMode(mode := 'default') {
    global pToken
    
    Radify.generals.safeMode := true
    vbs := 'SafeMode'
    
    switch mode, false {
        case 'net', 'network':
            vbs := 'SafeModeNetworking'
        case 'cmd', 'command', 'prompt':   
            vbs := 'SafeModeCommandPrompt'
        case 'exit', 'normal':
            vbs := 'SafeModeNormalMode'
            Radify.generals.safeMode := false        
    }
    
    return (*) => (
        OnMenuExit(),
        Cmd('wscript.exe "C:\ProgramData\WinaeroTweaker\' vbs '.vbs"').Call()
    )
}

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
        click: App('C:\Users\ToYu\AppData\Local\Vivaldi\Application\vivaldi.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\Vivaldi round.png'
      },
      {
        text: 'Xyplorer',
        click: App('C:\Users\ToYu\XYplorer\XYplorer.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer small.png'
      },
      {
        text: 'VPN',
        click: App('C:\Program Files\OpenVPN Connect\OpenVPNConnect.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\openVPN.png'
      },
      {
        text: 'Launcher',
        click: App('C:\Configs and settings\AutoHotKey\hotkeys\launcher.ahk'),
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\Mono\autohotkey.ico'
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
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Maxon\Maxon Cinema 4D\Maxon Cinema 4D 2025.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\cinema4d.png'
          },
          {
            text: 'Sketchfab',
            click: App('https://sketchfab.com/search?features=downloadable&q=model&type=models'),
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
            click: App('https://pixlr.com/ru/editor/'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\Adobe Photohop Eemet-10.png'
          },
          {
            text: 'Upscale',
            click: App('https://www.img2go.com/upscale-image'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\upscale.png', 
            ItemImageScale: 0.7
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
            click: App('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\CapCut\CapCut.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\McMuse\Dock Icon\capcut.png', 
            ItemImageScale: 0.7
          },        
          {
            text: 'VFX projects',
            click: Dir('V:\Music\VFX projects'),
            image: 'C:\Users\ToYu\Pictures\icons\shrooms\PNG\AdobeAfterEffect.png', 
            ItemImageScale: 0.85
          },
          {
            text: 'AfterFX',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Adobe After Effects 2024.lnk'),
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
        click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Syncovery x64\Syncovery.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Sync Center.ico', 
        ItemImageScale: 0.85
      },
      {
        text: 'Notepad++',
        click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Notepad++.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\Notepad++.png'
      },
      {
        text: 'GitButler',
        click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\GitButler\GitButler.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\gitbutler rounded2.png'
      }
    ]]), 
    rightClick: Sub(,[[
      {
        text: 'Релиз',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\github.png', 
        ItemImageScale: 1, 
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub(,[[
          {
            text: 'Virus',
            click: App('https://www.virustotal.com/gui/file/1e1027e81d1a188daff3c95dfa787f2fea2f85b81c15f32c4cedba3c6fbdd38a/behavior'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Shield X.ico'
          },
          {
            text: 'Releases',
            click: Dir('C:\Configs and settings\AutoHotKey\QuickSwitch\Releases'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\zip rounded.png'
          },
          {
            text: 'GitHub',
            click: App('https://github.com/JoyHak/QuickSwitch/releases'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\github.png', 
            ItemImageScale: 1
          },
          {
            text: 'Intezer',
            click: App('https://analyze.intezer.com/analyses/ed5d2df7-cf71-4aac-bea9-3011872f8492/dynamic-ttps'),
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
            click: App('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\File Explorer.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\explorer small.png'
          },
          {
            text: 'Xyplorer',
            click: App('C:\Users\ToYu\XYplorer\XYplorer.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer small.png'
          },
          {
            text: 'TotalCmd',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Total Commander\Total Commander 64 bit.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\totalcmd small.png'
          },
          {
            text: 'Dopus',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\GPSoftware\Directory Opus\Directory Opus.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\dopus small.png'
          },
        ]])
      },
      {
        text: 'Main',
        click: App('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\QuickSwitch.lnk'),
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
        image: 'C:\Users\ToYu\Pictures\icons\PNG\window manager UI 2.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
        click: Sub(,[[
          {
            text: 'MsStyleEditor',
            click: App('C:\Users\ToYu\msstyleEditor.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\window manager UI 2.png'
          },
          {
            text: 'Win10',
            click: App('C:\Users\ToYu\Win 10 Tweaker.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\Fluent Individual Icons\apps\wine.ico'
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
        text: 'Иконки',
        image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\icon edit scale ruby.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
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
            text: 'ResHacker',
            click: App('C:\Users\ToYu\Resource Hacker\ResourceHacker.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics\icon scale ruby edit 2.ico'
          },
          {
            text: 'FlatIcon',
            click: App('https://www.flaticon.com/search?word=performance&type=icon'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\flaticon.png', 
            ItemImageScale: 0.9
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
            click: App('C:\Users\ToYu\SysinternalsSuite\procexp64.exe'),
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
            text: 'Устройства',
            click: App('C:\Users\ToYu\AppData\Local\Stardock\Start10Ctrlpnl\Диспетчер устройств.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Device Keyboard.ico'
          },
          {
            text: 'Диски',
            click: App('C:\Users\ToYu\AppData\Local\Stardock\Start10Ctrlpnl\Создание и форматирование разделов жесткого диска.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\kora\drive-harddisk.png', 
            ItemImageScale: 0.7
          },
          {
            text: 'Панель',
            click: App('C:\Users\ToYu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Control Panel.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Windows Icons\Control Panel.ico', 
            ItemImageScale: 0.65
          },
          {
            text: 'Службы',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\services.lnk'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Services.ico', 
            ItemImageScale: 0.9
          },          
          {
            text: 'События',
            click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Event Viewer.lnk'),
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
    text: 'Текст',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\console3.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png',
    click: Sub(,[[
      {
        text: 'Flow Launcher',
        click: App('C:\Users\ToYu\FlowLauncher\Flow.Launcher.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\flow launcher.png', 
        ItemImageScale: 0.65
      },
      {
        text: 'Typora',
        click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Typora\Typora.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\typora2.png'
      },
      {
        text: 'CLion',
        click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\JetBrains\CLion 2024.1.5.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\clion.png'
      },
      {
        text: 'Warp',
        click: App('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Warp.lnk'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\console3.png'
      },
    ]])
  },  
  {
    text: 'Настройки',
    image: 'C:\Users\ToYu\Pictures\icons\PNG\settings_gray.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png', 
    click: Sub(,[[
      {
        text: 'Настройки',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\settings_gray.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png', 
        click: Sub(,[[
          {
            text: 'Настройки',
            click: App('ms-settings:'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\settings_gray.png'
          }, 
          {
            text: 'Графика',
            click: App('ms-settings:display-advancedgraphics'),
            image: 'C:\Users\ToYu\Pictures\icons\Antu (gradient)\network-card.ico', 
            ItemImageScale: 0.7
          },
        ]]),
      },      
      {
        text: 'Темы',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\color-management.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png', 
        click: Sub(,[[
          {
            text: 'Добавить тему',
            click: Dir('C:\Windows\Resources\Themes'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\folder colors small.png', 
            ItemImageScale: 0.85
          },
          {
            text: 'Фон',
            click: App('ms-settings:personalization-background'),
            image: 'C:\Users\ToYu\Pictures\icons\3D graphics_png\image-picture-viewer.png', 
            ItemImageScale: 0.85
          },
          {
            text: 'Внешний вид окон',
            click: App('SystemPropertiesPerformance.exe'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\window manager UI 2.png', 
            ItemImageScale: 0.7
          },
          {
            text: 'Изменить тему',
            click: App('ms-settings:themes'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\color-management.png'
          },
          {
            text: 'Цвет и прозрачность',
            click: App('ms-settings:colors'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\transparency.png'
          }
        ]])
      }, 
      {
        text: 'Перезапуск Проводника',
        click: Cmd('taskkill.exe /f /im explorer.exe & start explorer.exe'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\Explorer.png', 
        ItemImageScale: 0.65
      },
      {
        text: 'Таймер выключения',
        click: ShutdownMenu(),
        image: 'C:\Users\ToYu\Pictures\icons\Fluent Individual Icons\apps\kshutdown.ico'
      },
      {
        text: 'Загрузка системы',
        click: Cmd('shutdown.exe -r -o -f -t 0'),
        image: 'C:\Users\ToYu\Pictures\icons\Fluent Individual Icons\apps\kshutdown.ico'
      },
      { ; Войти/выйти из безопасного режима
        text:  safeMode ? 'Обычный режим' : 'Безопасный режим',
        click: safeMode ? SetSafeMode('exit') : SetSafeMode('network'),
        image: 'C:\Users\ToYu\Pictures\icons\Hemis\' . (safeMode ? 'warning2' : 'warning') . '.ico'
      },
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
    global pToken
    
    Radify.DisposeResources()
    Gdip_Shutdown(pToken)
}
    
ToggleSuspend() {
    Suspend(-1)
    TraySetIcon(A_IsSuspended 
        ? 'images\radify0.ico' 
        : 'images\radify0.ico')
}

OnMessage(0x404, OnTrayClick)
OnMessage(1075,  (*) => Radify.Show('main'))
OnExit(OnMenuExit)

TraySetIcon('images\radify1.ico',, true)

HotIfWinExist('RadifyGui_0_0 ahk_class AutoHotkeyGUI')
Hotkey('Esc', (*) => WinClose(WinExist()))
HotIfWinExist()