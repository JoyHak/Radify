#Requires AutoHotkey v2.0
#SingleInstance
#warn
#Include Radify.ahk
#Include lib\Callback\Callbacks.ahk
; #Include C:\Configs and settings\AutoHotKey\hotkeys\Lib\messages.ahk

Persistent()
CoordMode('tooltip', 'screen')
TraySetIcon('images\settings.ico', , true)
pToken := Gdip_Startup()


class Tip extends ICallback {
    __New(text, delayMs := 2000) {
        this.text := text
        this.delayMs := delayMs
    }
    
    Call() {
        ToolTip(this.text)      
        SetTimer(ToolTip, -this.delayMs)
    }
    
    ToString() => '"' . this.text . '"'
}


Radify.CreateMenu('main', [[
  {
    text: 'Keys',
    image: 'C:\Users\ToYu\Pictures\icons\clay_square\Mouseless.png',
    ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow2.png', 
    ; click: Sub(,[[
    submenu: [[
      {
        text: 'Доки',
        click: Tip('click'),
        shiftClick: Tip('shiftClick'),
        altClick: Tip('altClick'),
        ctrlClick: Tip('ctrlClick'),
        rightClick: Tip('rightClick'),
        image: 'C:\Users\ToYu\Pictures\icons\clay_square\Mouseless.png'
      },
      {
        text: 'Close',
        click: 'close',
        rightClick: 'closeMenu',
        shiftClick: 'drag',
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Button Close.ico', 
      }, 
      {
        text: 'PowerShell',
        click: Tip('open'),
        shiftClick: Tip('batch open'),
        image: 'C:\Users\ToYu\Pictures\icons\PNG\enter key.png'
      }
    ]],
    rightClick: Sub('lLinks',[[
      {
        text: 'Close2',
        click: 'close',
        rightClick: 'closeMenu',
        shiftClick: 'drag',
        image: 'C:\Users\ToYu\Pictures\icons\Lumicons\System\Button Close.ico', 
      },
      {
        text: 'Скрипты',
        image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer file.png',
        ItemBackgroundImage: 'C:\Configs and settings\AutoHotKey\Radify\Skins\Minimal\ItemGlow1.png', 
        click: Sub('lScripts',[[
          {
            text: 'Xyplorer',
            click: Tip('C:\Users\ToYu\XYplorer\Data\Scripts'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\xyplorer file.png'
          },
          {
            text: 'PowerShell',
            click: Tip('C:\Configs and settings\PowerShell'),
            image: 'C:\Users\ToYu\Pictures\icons\PNG\console3.png'
          },
          {
            text: 'AutoHotKey',
            click: Tip('C:\Configs and settings\AutoHotKey'),
            image: 'C:\Users\ToYu\Pictures\icons\Lumicons\Mono\autohotkey.ico'
          }
        ]])
      }
    ]])
  }, 
  {
    text: 'PowerShell',
    click: Tip('open'),
    shiftClick: Tip('batch open'),
    image: 'C:\Users\ToYu\Pictures\icons\PNG\enter key.png', 
  }
]], 
  {
    autoTooltip: true, 
    autoTooltipStructure: true
  }
)

OnMenuExit(exitReason := 'exit', exitCode := 0) {
    Radify.DisposeResources()
    Gdip_Shutdown(pToken)
}

OnExit(OnMenuExit)

Hotkey('+!5', (*) => Radify.Show('Main'), 'On')