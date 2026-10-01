#Requires AutoHotkey v2.0
#SingleInstance
#Include Radify.ahk
#Include lib\Callback\Callbacks.ahk

Persistent()
SetWorkingDir(A_ScriptDir)
TraySetIcon('images\radify0.ico',, true)
pToken := Gdip_Startup()

#Include Examples.ahk

; This is your root (or main) menu. You can name it as you want (e.g. "MyMenu"), but the name must be unique.
Radify.CreateMenu('mainMenu', [
    [   ; ring 1
        {
            ; To create a submenu, simply use `Submenu()` function or `submenu:` property with options
            click: Submenu("Applications", appsMenu),
            rightClick: Submenu("Websites", websitesMenu, websitesMenuOptions),
            shiftClick: Submenu("Scripts", scriptsMenu),
            altClick: Submenu("Symbols", symbolMenu, symbolMenuOptions),
            ctrlClick: Submenu("Emoji", emojisMenu, emojisMenuOptions),
            text: 'Apps',   ; This is main item text
            /**
             * You can add Submenu() without a name or pass rings directly: 
             * @example
             * Submenu(, [
             *    [
             *        {image: 'autohotkey.ico', text: 'QuickSwitch'},
             *        {image: 'autohotkey beta.ico', text: 'Radify'},
             *        {image: 'aquahotkey.png', text: 'AquaHotkey'}
             *    ]
             * ])
             * Name will be auto-generated.
            */
            
            ; Auto-generate tooltip based on privided submenus and "click" actions
            enableTooltip: true,
            autoTooltip: true,
            autoTooltipStructure: true,
            autoTooltipMenuItemTextFirst: false,
            
            image: 'pointer.ico',
            itemImageScale: 2,
            itemImageYRatio: 0.40,
            textYRatio: 0.75
        }
    ],
    [   ; ring 2
        {image: 'calculator.png', click: App('calc.exe')},
        {image: 'notepad.png', click: App('notepad.exe')},
        {image: 'documents.png', click: App(A_MyDocuments)},
        {
            image: 'emoji_robot.png',
            text: 'AI',
            itemImageScale: 0.30,
            itemImageYRatio: 0.40,
            textYRatio: 0.78,
            submenu: aiMenu,
            submenuOptions: aiMenuOptions,
        },
        {
            image: 'shopping.png',
            text: 'Shopping',
            itemImageScale: 0.30,
            itemImageYRatio: 0.40,
            textYRatio: 0.75,
            submenu: shoppingMenu,
            submenuOptions: shoppingMenuOptions,
        },
        {
            image: 'lightning.png',
            text: 'Power',
            tooltip: '• System power options •`nShutdown, Restart, Sleep, etc.',
            itemImageScale: 0.30,
            itemImageYRatio: 0.40,
            textYRatio: 0.75,
            submenu: systemPowerMenu,
            submenuOptions: systemPowerMenuOptions,
        },
        {
            image: 'Battery1.png',
            text: 'Plans',
            tooltip: '• Power Plans •`nRight-Click: Open Control Panel > Power Options',
            rightClick: App('powercfg.cpl'),
            itemImageScale: 0.30,
            itemImageYRatio: 0.40,
            textYRatio: 0.75,
            submenu: powerPlansMenu,
        },
        {
            image: 'cleaning-brush.png',
            text: 'Cleanup',
            itemImageScale: 0.35,
            itemImageYRatio: 0.40,
            textYRatio: 0.75,
            submenu: systemCleanupMenu,
        },
        {
            image: 'tool-box.png',
            text: 'Tools',
            itemImageScale: 0.35,
            itemImageYRatio: 0.40,
            textYRatio: 0.75,
            submenu: toolsMenu,
        },
        {
            image: 'settings-app.png',
            text: 'Settings',
            tooltip: '• Windows Settings •`nRight-Click: Open Windows Settings app',
            rightClick: App('ms-settings:'),
            itemImageScale: 0.30,
            itemImageYRatio: 0.40,
            textYRatio: 0.75,
            submenu: settingsMenu,
        },
        {image: 'magnifier.png', click: App('magnify.exe')},
    ],
    [   ; ring 3
        {image: 'snipping-tool.png', click: App('snippingTool.exe')},
        {image: 'snip-sketch.png', click: App('ms-screenclip:')},
        {},
        {},
        {image: 'radify-skin-editor.png', click: App('Radify Skin Editor.ahk'), tooltip: 'Open Radify Skin Editor'},
        {image: 'folder-orange.png', click: App(A_ScriptDir), tooltip: 'Open Script Folder'},
        {image: 'edit-orange.png', click: (*) => Edit(), tooltip: 'Edit Menu'},
        {image: 'reload-orange.png', click: (*) => Reload(), tooltip: 'Reload'},
        {image: 'close.png', click: 'close', tooltip: 'Close'},
        {},
        {},
        {},
        {},
        {},
        {image: 'control-panel.png', click: Dir('shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}')},
        {image: 'task-manager.png', click: App('taskmgr.exe')},
        {image: 'system-display-settings-app.png', click: App('ms-settings:display'), tooltip: 'Display settings'},
        {image: 'cmd.png', click: App('Scripts\AdminCmd.ahk'), tooltip: 'Command Prompt as Administrator'},
        {image: 'powershell.png', click: App('Scripts\AdminPowerShell.ahk'), tooltip: 'PowerShell as Administrator'},
    ],
], 
{
    ; Close menu after selection
    closeOnItemClick: true,
    closeOnItemRightClick: true,
    ; But keep open while you holding "Alt"
    stayOpenOn: 'alt',
})


InitTrayMenu(*) {
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
    for i in trayMenu {
        A_TrayMenu.Add(i.text, i.click)
        A_TrayMenu.SetIcon(i.text, i.image)
    }

    
    OnTrayClick(wParam, lParam, uMsg, hWnd) {
        static WM_LBUTTONDOWN := 0x201
        if (lParam = WM_LBUTTONDOWN) {        
            Radify.Show('main')
        }
    }
    
    ToggleSuspend() {
        Suspend(-1)
        TraySetIcon('images\radify' (!A_IsSuspended) '.ico')
    }
    
    OnMessage(0x404, OnTrayClick)
    TraySetIcon('images\radify1.ico',, true)
}

OnMenuExit(exitReason := 'exit', exitCode := 0) {   
    Radify.DisposeResources()
    Gdip_Shutdown(pToken)
}

; OnMessage(msg.key.LWin, ShowMenu)
OnExit(OnMenuExit)

Hotkey('$LWin', (*) => Radify.Show('mainMenu'), 'On')
; Hotkey('^s', (*) => Reload(), 'On')
InitTrayMenu()