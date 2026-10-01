; Here you can define your menus.
; Each menu is an Array of Arrays (rings).
; Each ring contains Objects (items).
; Each item can have it's own set of properties (options).
; "click" action requires BoundFunc, fat-arrow function or ICallback
websitesMenu := [
    [   ; ring 1
        {image: 'google-chrome.png', click: Web('https://www.google.com'), tooltip: 'Google Search'},
        {image: 'gmail.png', click: Web('https://mail.google.com')},
        {image: 'microsoft-outlook.png', click: Web('https://outlook.live.com/mail')},
        {image: 'x-twitter.png', click: Web('https://twitter.com')},
        {image: 'youtube.png', click: Web('https://www.youtube.com/feed/subscriptions')},
        {image: 'facebook.png', click: Web('https://www.facebook.com')},
    ],
    [   ; ring 2
        {image: 'google-drive.png', click: Web('https://drive.google.com')},
        {image: 'google-photos.png', click: Web('https://photos.google.com')},
        {image: 'google-keep.png', click: Web('https://keep.google.com')},
        {image: 'reddit.png', click: Web('https://www.reddit.com')},
        {image: 'odysee.png', click: Web('https://odysee.com')},
        {image: 'rumble.png', click: Web('https://rumble.com')},
        {image: 'bitchute.png', click: Web('https://www.bitchute.com')},
        {image: 'vimeo.png', click: Web('https://vimeo.com')},
        {image: 'twitch.png', click: Web('https://www.twitch.tv')},
        {image: 'spotify.png', click: Web('https://open.spotify.com')},
        {image: 'duckduckgo.png', click: Web('https://duckduckgo.com')},
        {image: 'dropbox.png', click: Web('https://www.dropbox.com')},
    ],
    [   ; ring 3
        {image: 'google-maps.png', click: Web('https://www.google.com/maps')},
        {image: 'google-calendar.png', click: Web('https://calendar.google.com')},
        {image: 'google-translate.png', click: Web('https://translate.google.com')},
        {image: 'google-spreadsheets.png', click: Web('https://docs.google.com/spreadsheets')},
        {image: 'google-documents.png', click: Web('https://docs.google.com/document')},
        {image: 'instagram.png', click: Web('https://www.instagram.com')},
        {image: 'tiktok.png', click: Web('https://www.tiktok.com')},
        {image: 'telegram.png', click: Web('https://web.telegram.org')},
        {image: 'whatsapp.png', click: Web('https://web.whatsapp.com')},
        {image: 'messenger.png', click: Web('https://www.messenger.com')},
        {image: 'discord.png', click: Web('https://discord.com')},
        {image: 'zoom.png', click: Web('https://zoom.us')},
        {image: 'skype.png', click: Web('https://web.skype.com')},
        {image: 'linkedin.png', click: Web('https://www.linkedin.com')},
        {image: 'paypal.png', click: Web('https://www.paypal.com')},
        {image: 'stripe.png', click: Web('https://dashboard.stripe.com')},
        {
            image: 'reddit.png',
            click: Web('https://www.reddit.com/r/AutoHotkey'),
            text: 'r/AHK',
            tooltip: 'r/AutoHotkey',
            itemImageScale: 0.35,
            itemImageYRatio: 0.25,
            textYRatio: 0.75,
        },
        {
            image: 'autohotkey.ico',
            click: Web('https://www.autohotkey.com/boards'),
            text: 'Forum',
            tooltip: 'AutoHotkey Forum',
            itemImageScale: 0.35,
            itemImageYRatio: 0.25,
            textYRatio: 0.75,
        },
        {
            image: 'autohotkey.ico',
            click: Web('https://www.autohotkey.com/docs/v2'),
            text: 'Doc',
            tooltip: 'AutoHotkey Documentation',
            itemImageScale: 0.35,
            itemImageYRatio: 0.25,
            textYRatio: 0.75,
        },
    ],
]

websitesMenuOptions := {mirrorClickToRightClick: true, closeOnItemRightClick: false, itemSize: 60}

Radify.CreateMenu('websitesMenu', websitesMenu, websitesMenuOptions)


aiMenu := [
    [
        {image: 'grok.png', click: Web('https://x.com/i/grok')},
        {image: 'claude.png', click: Web('https://claude.ai')},
        {image: 'chatgpt.png', click: Web('https://chatgpt.com')},
        {image: 'gemini.png', click: Web('https://gemini.google.com')},
        {image: 'deepseek.png', click: Web('https://chat.deepseek.com')},
        {image: 'perplexity.png', click: Web('https://www.perplexity.ai')},
    ],
    [
        {image: 'microsoft-copilot.png', click: Web('https://copilot.microsoft.com')},
        {image: 'bing.png', click: Web('https://www.bing.com/images/create'), tooltip: 'Bing Image Creator'},
        {image: 'mistral.png', click: Web('https://chat.mistral.ai')},
        {image: 'openrouter.png', click: Web('https://openrouter.ai')},
        {image: 'huggingface.png', click: Web('https://huggingface.co/chat')},
        {image: 'poe.png', click: Web('https://poe.com')},
        {image: 'character-ai.png', click: Web('https://character.ai')},
        {image: 'suno.png', click: Web('https://suno.com'), tooltip: 'Suno - AI Music'},
        {image: 'playground.png', click: Web('https://playground.com')},
        {image: 'midjourney.png', click: Web('https://midjourney.com')},
        {image: 'stable-diffusion.png', click: Web('https://stability.ai')},
        {image: 'leonardo.png', click: Web('https://leonardo.ai')},
    ],
]

aiMenuOptions := {mirrorClickToRightClick: true, closeOnItemRightClick: false}

Radify.CreateMenu('aiMenu', aiMenu, aiMenuOptions)


shoppingMenu := [
    [
        {text: 'Amazon', click: Web('https://www.amazon.com')},
        {text: 'Ebay', click: Web('https://www.ebay.com')},
        {text: 'Bestbuy', click: Web('https://www.bestbuy.com')},
        {text: 'Costco', click: Web('https://www.costco.com')},
        {text: 'Walmart', click: Web('https://www.walmart.com')},
        {text: 'Target', click: Web('https://www.target.com')},
    ],
    [
        {text: 'Newegg', click: Web('https://www.newegg.com')},
        {text: 'Staples', click: Web('https://www.staples.com')},
        {text: 'Ali`nExpress', click: Web('https://www.aliexpress.com')},
        {text: 'Home Depot', click: Web('https://www.homedepot.com')},
        {text: 'Lowes', click: Web('https://www.lowes.com')},
        {text: 'IKEA', click: Web('https://www.ikea.com')},
        {text: 'Wayfair', click: Web('https://www.wayfair.com')},
        {text: 'Etsy', click: Web('https://www.etsy.com')},
        {text: 'Macys', click: Web('https://www.macys.com')},
        {text: 'Under`nArmour', click: Web('https://www.underarmour.com')},
        {text: 'Nike', click: Web('https://www.nike.com')},
        {text: 'Adidas', click: Web('https://www.adidas.com')},
        {text: 'Zara', click: Web('https://www.zara.com')},
    ],
]

shoppingMenuOptions := {mirrorClickToRightClick: true, closeOnItemRightClick: false}


appsMenu := [
    [
        {image: 'calculator.png', click: App('calc.exe')},
        {image: 'notepad.png', click: App('notepad.exe')},
        {image: 'wordpad.png', click: App('wordpad.exe')},
        {image: 'paint.png', click: App('mspaint.exe')},
        {image: 'osk.png', click: App('osk.exe'), tooltip: 'On-Screen Keyboard'},
    ],
]

Radify.CreateMenu('appsMenu', appsMenu)


settingsMenu := [
	[
        {image: 'bluetooth-settings-app.png', click: App('ms-settings:bluetooth')},
        {image: 'system-display-settings-app.png', click: App('ms-settings:display')},
        {image: 'sound-settings-app.png', click: App('ms-settings:sound')},
        {image: 'sound-control-panel.png', click: App('mmsys.cpl')},
        {image: 'devices-printers-settings-app.png', click: App('control printers')},
        {image: 'devices-printers-control-panel.png', click: App('shell:::{A8A91A66-3A7D-4424-8D24-04E180695C7A}')},
    ],
    [
        {image: 'power-options-settings-app.png', click: App('ms-settings:powersleep')},
        {image: 'power-options-control-panel.png', click: App('powercfg.cpl')},
        {image: 'installedApps-settings-app.png', click: App('ms-settings:appsfeatures')},
        {image: 'programs-features-control-panel.png', click: App('appwiz.cpl')},
        {image: 'system.png', click: App('SystemPropertiesAdvanced.exe'), tooltip: 'System Properties > Advanced'},
        {
            image: 'system-environment-variables.png',
            click: App('rundll32.exe sysdm.cpl,EditEnvironmentVariables'),
            tooltip: 'System Properties > Advanced > Environment Variables'
        },
		{image: 'network-connections.png', click: App('shell:::{7007ACC7-3202-11D1-AAD2-00805FC1270E}')},
        {image: 'windows-defender.png', click: App('explorer.exe windowsdefender:')},
        {image: 'folder-options.png', click: App('shell:::{6DFD7C5C-2451-11d3-A299-00C04F8EF6AF}')},
        {image: 'control-panel.png', click: App('shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}'), tooltip: 'Control Panel'},
        {
            image: 'control-panel.png',
            click: App('shell:::{ED7BA470-8E54-465E-825C-99712043E01C}'),
            text: 'All Tasks',
            itemImageScale: 0.40,
            itemImageYRatio: 0.20,
            textYRatio: 0.65,
        },
        {
            image: 'programs-features.png',
            click: App('OptionalFeatures.exe'),
            tooltip: 'Turn Windows features on or off',
            text: 'Windows`nFeatures',
            itemImageScale: 0.35,
            itemImageYRatio: 0.20,
            textYRatio: 0.70,
        },
	],
]

Radify.CreateMenu('settingsMenu', settingsMenu)


toolsMenu := [
	[
        {image: 'device-manager.png', click: App('devmgmt.msc')},
		{image: 'disk-management.png', click: App('diskmgmt.msc')},
		{image: 'computer-management.png', click: App('compmgmt.msc')},
		{image: 'system-configuration.png', click: App('msconfig.exe')},
        {image: 'system-information.png', click: App('msinfo32.exe')},
		{image: 'task-scheduler.png', click: App('taskschd.msc')},
	],
	[
        {image: 'windows-tools.png', click: App('shell:::{D20EA4E1-3957-11D2-A40B-0C5020524153}')},
		{image: 'services.png', click: App('services.msc')},
		{image: 'registry-editor.png', click: App('regedit.exe')},
		{image: 'optimize-drives.png', click: App('dfrgui.exe')},
        {image: 'system-image.png', click: App('sdclt.exe /BLBBACKUPWIZARD')},
        {image: 'event-viewer.png', click: App('eventvwr.msc')},
        {image: 'windows-firewall.png', click: App('WF.msc')},
        {
            image: 'monitor.png',
            click: App('resmon.exe'),
            text: 'Resmon',
            tooltip: 'Resource Monitor',
            itemImageScale: 0.40,
            itemImageYRatio: 0.25,
            textYRatio: 0.75,
        },
        {
            image: 'monitor.png',
            click: App('perfmon.exe'),
            text: 'Perfmon',
            tooltip: 'Performance Monitor',
            itemImageScale: 0.40,
            itemImageYRatio: 0.25,
            textYRatio: 0.75,
        },
	],
]


powerPlansMenu := [
    [
        {image: 'Battery1.png', text: 'High', click: Cmd('powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c'), tooltip: 'High Performance'},
        {image: 'Battery2.png', text: 'Balanced', click: Cmd('powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e'), tooltip: 'Balanced'},
        {image: 'Battery3.png', text: 'Saver', click: Cmd('powercfg -setactive a1841308-3541-4fab-bc81-f71556f20b4a'), tooltip: 'Power Saver'},
        {},
        {},
    ],
]


scriptsMenu := [
    [
        {image: 'autohotkey.ico', text: 'QuickSwitch'},
        {image: 'autohotkey beta.ico', text: 'Radify'},
        {image: 'aquahotkey.png', text: 'AquaHotkey'}
    ],
]


systemCleanupMenu := [
	[
        {
            image: 'recycle-bin.png',
            click: Dir('shell:::{645FF040-5081-101B-9F08-00AA002F954E}'),
            rightClick: Dir('Scripts\EmptyRecycleBin.ahk'),
            tooltip: 'Click: Open recycle bin`nRight-Click: Empty recycle bin',
        },
        {image: 'disk-cleanup.png', click: App('cleanmgr.exe')},
        {text: 'Win Temp', click: Dir(A_WinDir '\Temp'), tooltip: 'Windows system Temp folder'},
        {text: 'Temp', click: Dir(A_Temp), tooltip: 'User Temp Folder'},
        {text: 'Prefetch', click: Dir(A_WinDir '\Prefetch'), tooltip: 'Prefetch folder'},
        {text: 'Software Distribution', click: Dir(A_WinDir '\SoftwareDistribution\Download'), tooltip: 'Windows Update cache folder', textSize:9},
        {text: 'Storage Sense', click: App('ms-settings:storagesense')},
	],
]


strSystemPower :=  ' - Right-Click: Execute action.`nMake sure to save your work before proceeding.'

systemPowerMenu := [
	[
        {image: 'shutdown.png', rightClick: (*) => (Sleep(1500), Shutdown(8)), tooltip: 'Shutdown' strSystemPower},
        {image: 'restart.png', rightClick: (*) => (Sleep(1500), Shutdown(2)), tooltip: 'Restart' strSystemPower},
        {image: 'sleep.png', rightClick: (*) => (Sleep(1500), DllCall('PowrProf\SetSuspendState', 'int', 0, 'int', 0, 'int', 0)), tooltip: 'Sleep' strSystemPower},
        {image: 'advanced-startup.png', rightClick: (*) => (Sleep(1500), Run('shutdown.exe /r /o /t 0')), tooltip: 'Advanced Startup' strSystemPower},
        {image: 'restart-safe-mode.png', rightClick: (*) => (Sleep(1500), Run('Scripts\RestartSafeMode.ahk')), tooltip: 'Restart to Safe Mode' strSystemPower},
	],
]

systemPowerMenuOptions := {closeOnItemClick: false}

Radify.CreateMenu('systemPowerMenu', systemPowerMenu, systemPowerMenuOptions)


symbolMenu := [
    [
        {text: Chr(123) Chr(125), click: Clip(Chr(123) Chr(125)), tooltip: 'Curly brackets'}, ; {}
        {text: Chr(125), click: Clip(Chr(125)), tooltip: 'Closing curly bracket'}, ; }
        {text: Chr(93), click: Clip(Chr(93)), tooltip: 'Closing square bracket'}, ; ]
        {text: Chr(91) Chr(93), click: Clip(Chr(91) Chr(93)), tooltip: 'Square brackets'}, ; []
        {text: Chr(91), click: Clip(Chr(91)), tooltip: 'Opening square bracket'}, ; [
        {text: Chr(123), click: Clip(Chr(123)), tooltip: 'Opening curly bracket'}, ; {
    ],
    [
        {text: Chr(40) Chr(41), click: Clip(Chr(40) Chr(41)), tooltip: 'Parentheses'}, ; ()
        {text: Chr(41), click: Clip(Chr(41)), tooltip: 'Closing parenthesis'}, ; )
        {text: Chr(37), click: Clip(Chr(37)), tooltip: 'Percent sign'}, ; %
        {text: Chr(37) Chr(37), click: Clip(Chr(37) Chr(37)), textSize: 20, tooltip: 'Double percent sign'}, ; %%
        {text: Chr(47), click: Clip(Chr(47)), tooltip: 'Forward slash'}, ; /
        {text: Chr(62), click: Clip(Chr(62)), tooltip: 'Greater-than sign'}, ; >
        {text: Chr(60) Chr(62), click: Clip(Chr(60) Chr(62)), tooltip: 'Angle brackets', textSize: 30}, ; <>
        {text: Chr(60), click: Clip(Chr(60)), tooltip: 'Less-than sign'}, ; <
        {text: Chr(92), click: Clip(Chr(92)), tooltip: 'Backslash'}, ; \
        {text: Chr(8220) Chr(8221), click: Clip(Chr(8220) Chr(8221)), tooltip: 'Double quotation marks'}, ; ""
        {text: Chr(8216) Chr(8217), click: Clip(Chr(8216) Chr(8217)), tooltip: 'Single quotation marks'}, ; ''
        {text: Chr(40), click: Clip(Chr(40)), tooltip: 'Opening parenthesis'}, ; (
    ],
    [
        ; — Common Symbols —
        {text: Chr(35), click: Clip(Chr(35)), tooltip: 'Hash sign'}, ; #
        {text: Chr(38), click: Clip(Chr(38)), tooltip: 'Ampersand'}, ; &
        {text: Chr(64), click: Clip(Chr(64)), tooltip: 'At symbol'}, ; @
        {text: Chr(176), click: Clip(Chr(176)), tooltip: 'Degree symbol'}, ; °

        ; — Math & Logic Symbols —
        {text: Chr(8734), click: Clip(Chr(8734)), tooltip: 'Infinity symbol'}, ; ∞
        {text: Chr(8730), click: Clip(Chr(8730)), tooltip: 'Square root'}, ; √
        {text: Chr(177), click: Clip(Chr(177)), tooltip: 'Plus-minus sign'}, ; ±
        {text: Chr(8709), click: Clip(Chr(8709)), tooltip: 'Empty set'}, ; ∅
        {text: Chr(8800), click: Clip(Chr(8800)), tooltip: 'Not equal to'}, ; ≠
        {text: Chr(8805), click: Clip(Chr(8805)), tooltip: 'Greater than or equal to'}, ; ≥
        {text: Chr(8804), click: Clip(Chr(8804)), tooltip: 'Less than or equal to'}, ; ≤
        {text: Chr(8658), click: Clip(Chr(8658)), tooltip: 'Implies'}, ; ⇒

        {text: Chr(126), click: Clip(Chr(126)), tooltip: 'Tilde'}, ; ~
        {text: Chr(124), click: Clip(Chr(124)), tooltip: 'Pipe'}, ; |
        {text: Chr(94), click: Clip(Chr(94)), tooltip: 'Caret'}, ; ^
        {text: '=' Chr(62), click: Clip('=' Chr(62)), tooltip: 'Fat arrow', textSize: 30}, ; =>
        {text: Chr(96), click: Clip(Chr(96)), tooltip: 'Backtick'}, ; `
        {text: '``n', click: Clip('``n'), tooltip: 'Line feed'}, ; `n
        {text: '``r', click: Clip('``r'), tooltip: 'Carriage return'}, ; `r
    ],
    [
        {text: Chr(8801), click: Clip(Chr(8801)), tooltip: 'Identical to'}, ; ≡
        {text: Chr(8776), click: Clip(Chr(8776)), tooltip: 'Approximately equal to'}, ; ≈
        {text: Chr(181), click: Clip(Chr(181)), tooltip: 'Micro symbol'}, ; µ
        {text: Chr(188), click: Clip(Chr(188)), tooltip: 'One quarter'}, ; ¼
        {text: Chr(8531), click: Clip(Chr(8531)), tooltip: 'One third'}, ; ⅓
        {text: Chr(189), click: Clip(Chr(189)), tooltip: 'One half'}, ; ½
        {text: Chr(8532), click: Clip(Chr(8532)), tooltip: 'Two thirds'}, ; ⅔
        {text: Chr(190), click: Clip(Chr(190)), tooltip: 'Three quarters'}, ; ¾

        ; — Currency Symbols —
        {text: Chr(8364), click: Clip(Chr(8364)), tooltip: 'Euro symbol'}, ; €
        {text: Chr(163), click: Clip(Chr(163)), tooltip: 'Pound symbol'}, ; £
        {text: Chr(165), click: Clip(Chr(165)), tooltip: 'Yen symbol'}, ; ¥
        {text: Chr(8383), click: Clip(Chr(8383)), tooltip: 'Bitcoin symbol'}, ; ₿
        {text: Chr(162), click: Clip(Chr(162)), tooltip: 'Cent symbol'}, ; ¢

        ; — Arrows & Directional —
        {text: Chr(8592), click: Clip(Chr(8592)), tooltip: 'Left arrow'}, ; ←
        {text: Chr(8594), click: Clip(Chr(8594)), tooltip: 'Right arrow'}, ; →
        {text: Chr(8593), click: Clip(Chr(8593)), tooltip: 'Up arrow'}, ; ↑
        {text: Chr(8595), click: Clip(Chr(8595)), tooltip: 'Down arrow'}, ; ↓
        {text: Chr(8596), click: Clip(Chr(8596)), tooltip: 'Left-right arrow'}, ; ↔
        {text: Chr(8597), click: Clip(Chr(8597)), tooltip: 'Up-down arrow'}, ; ↕
        {text: Chr(8656), click: Clip(Chr(8656)), tooltip: 'Left double arrow'}, ; ⇐
        {text: Chr(9650), click: Clip(Chr(9650)), tooltip: 'Up triangle'}, ; ▲
        {text: Chr(9660), click: Clip(Chr(9660)), tooltip: 'Down triangle'}, ; ▼

        ; — Legal & Trademark —
        {text: Chr(169), click: Clip(Chr(169)), tooltip: 'Copyright symbol'}, ; ©
        {text: Chr(174), click: Clip(Chr(174)), tooltip: 'Registered trademark'}, ; ®
        {text: Chr(8482), click: Clip(Chr(8482)), tooltip: 'Trademark symbol'}, ; ™
    ],
]

symbolMenuOptions := {enableItemText: true, mirrorClickToRightClick: true, closeOnItemRightClick: false, textSize: 33, itemSize: 60}


emojisMenu := [
    [
        {image: 'emoji_face_with_tears_of_joy.png', click: Clip('😂'), tooltip: 'Face with tears of joy'},
        {image: 'emoji_rolling_on_the_floor_laughing.png', click: Clip('🤣'), tooltip: 'Rolling on the floor laughing'},
        {image: 'emoji_loudly_crying_face.png', click: Clip('😭'), tooltip: 'Loudly crying face'},
        {image: 'emoji_grinning_face_with_sweat.png', click: Clip('😅'), tooltip: 'Grinning face with sweat'},
        {image: 'emoji_winking_face.png', click: Clip('😉'), tooltip: 'Winking face'},
        {image: 'emoji_winking_face_with_tongue.png', click: Clip('😜'), tooltip: 'Winking face with tongue'},
    ],
    [
        {image: 'emoji_grinning_face.png', click: Clip('😀'), tooltip: 'Grinning face'},
        {image: 'emoji_beaming_face_with_smiling_eyes.png', click: Clip('😁'), tooltip: 'Beaming face with smiling eyes'},
        {image: 'emoji_smiling_face_with_smiling_eyes.png', click: Clip('😊'), tooltip: 'Smiling face with smiling eyes'},
        {image: 'emoji_smiling_face_with_sunglasses.png', click: Clip('😎'), tooltip: 'Smiling face with sunglasses'},
        {image: 'emoji_smirking_face.png', click: Clip('😏'), tooltip: 'Smirking face'},
        {image: 'emoji_crying_face.png', click: Clip('😢'), tooltip: 'Crying face'},
        {image: 'emoji_pleading_face.png', click: Clip('🥺'), tooltip: 'Pleading face'},
        {image: 'emoji_face_with_rolling_eyes.png', click: Clip('🙄'), tooltip: 'Face with rolling eyes'},
        {image: 'emoji_unamused_face.png', click: Clip('😒'), tooltip: 'Unamused face'},
        {image: 'emoji_pensive_face.png', click: Clip('😔'), tooltip: 'Pensive face'},
        {image: 'emoji_smiling_face_with_hearts.png', click: Clip('🥰'), tooltip: 'Smiling face with hearts'},
        {image: 'emoji_smiling_face_with_heart_eyes.png', click: Clip('😍'), tooltip: 'Smiling face with heart-eyes'},
        {image: 'emoji_face_blowing_a_kiss.png', click: Clip('😘'), tooltip: 'Face blowing a kiss'},
    ],
    [
        {image: 'emoji_angry_face.png', click: Clip('😠'), tooltip: 'Angry face'},
        {image: 'emoji_pouting_face.png', click: Clip('😡'), tooltip: 'Pouting face'},
        {image: 'emoji_face_with_steam_from_nose.png', click: Clip('😤'), tooltip: 'Face with steam from nose'},
        {image: 'emoji_exploding_head.png', click: Clip('🤯'), tooltip: 'Exploding head'},
        {image: 'emoji_face_with_open_mouth.png', click: Clip('😮'), tooltip: 'Face with open mouth'},
        {image: 'emoji_sleeping_face.png', click: Clip('😴'), tooltip: 'Sleeping face'},
        {image: 'emoji_thinking_face.png', click: Clip('🤔'), tooltip: 'Thinking face'},
        {image: 'emoji_shushing_face.png', click: Clip('🤫'), tooltip: 'Shushing face'},
        {image: 'emoji_thumbs_up.png', click: Clip('👍'), tooltip: 'Thumbs up'},
        {image: 'emoji_thumbs_down.png', click: Clip('👎'), tooltip: 'Thumbs down'},
        {image: 'emoji_ok_hand.png', click: Clip('👌'), tooltip: 'OK hand'},
        {image: 'emoji_victory_hand.png', click: Clip('✌️'), tooltip: 'Victory hand'},
        {image: 'emoji_raised_hand.png', click: Clip('✋'), tooltip: 'Raised hand'},
        {image: 'emoji_clapping_hands.png', click: Clip('👏'), tooltip: 'Clapping hands'},
        {image: 'emoji_waving_hand.png', click: Clip('👋'), tooltip: 'Waving hand'},
        {image: 'emoji_heart_hands.png', click: Clip('🫶'), tooltip: 'Heart hands'},
        {image: 'emoji_flexed_biceps.png', click: Clip('💪'), tooltip: 'Flexed biceps'},
        {image: 'emoji_folded_hands.png', click: Clip('🙏'), tooltip: 'Folded hands'},
        {image: 'emoji_man_shrugging.png', click: Clip('🤷‍♂️'), tooltip: 'Man shrugging'},
        {image: 'emoji_eyes.png', click: Clip('👀'), tooltip: 'Eyes'},
    ],
    [
        {image: 'emoji_hundred_points.png', click: Clip('💯'), tooltip: 'Hundred points'},
        {image: 'emoji_red_heart.png', click: Clip('❤️'), tooltip: 'Red heart'},
        {image: 'emoji_two_hearts.png', click: Clip('💕'), tooltip: 'Two hearts'},
        {image: 'emoji_fire.png', click: Clip('🔥'), tooltip: 'Fire'},
        {image: 'emoji_high_voltage.png', click: Clip('⚡'), tooltip: 'High voltage'},
        {image: 'emoji_dog_face.png', click: Clip('🐶'), tooltip: 'Dog face'},
        {image: 'emoji_cat_face.png', click: Clip('🐱'), tooltip: 'Cat face'},
        {image: 'emoji_clown_face.png', click: Clip('🤡'), tooltip: 'Clown face'},
        {image: 'emoji_robot.png', click: Clip('🤖'), tooltip: 'Robot face'},
        {image: 'emoji_panda.png', click: Clip('🐼'), tooltip: 'Panda face'},
        {image: 'emoji_alien.png', click: Clip('👽'), tooltip: 'Alien'},
        {image: 'emoji_skull.png', click: Clip('💀'), tooltip: 'Skull'},
        {image: 'emoji_pile_of_poo.png', click: Clip('💩'), tooltip: 'Pile of poo'},
        {image: 'emoji_bullseye.png', click: Clip('🎯'), tooltip: 'Bullseye'},
        {image: 'emoji_popcorn.png', click: Clip('🍿'), tooltip: 'Popcorn'},
        {image: 'emoji_party_popper.png', click: Clip('🎉'), tooltip: 'Party popper'},
        {image: 'emoji_balloon.png', click: Clip('🎈'), tooltip: 'Balloon'},
        {image: 'emoji_collision.png', click: Clip('💥'), tooltip: 'Collision'},
        {image: 'emoji_rocket.png', click: Clip('🚀'), tooltip: 'Rocket'},
        {image: 'emoji_stop_sign.png', click: Clip('🛑'), tooltip: 'Stop sign'},
        {image: 'emoji_brain.png', click: Clip('🧠'), tooltip: 'Brain'},
        {image: 'emoji_hamburger.png', click: Clip('🍔'), tooltip: 'Hamburger'},
        {image: 'emoji_pizza.png', click: Clip('🍕'), tooltip: 'Pizza'},
        {image: 'emoji_check_mark_button.png', click: Clip('✅'), tooltip: 'Check mark'},
        {image: 'emoji_light_bulb.png', click: Clip('💡'), tooltip: 'Light bulb'},
        {image: 'emoji_sparkles.png', click: Clip('✨'), tooltip: 'Sparkles'},
        {image: 'emoji_glowing_star.png', click: Clip('🌟'), tooltip: 'Glowing star'},
    ],
]

emojisMenuOptions := {mirrorClickToRightClick: true, closeOnItemRightClick: false, itemSize: 60}