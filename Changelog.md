## Design

I've improved the menu's design and behavior. The `Minimal` skin is now more visible and stands out clearly from the background windows, and the menu borders are distinct from one another. Opening a submenu no longer closes the parent menu. Path Finding now searches for items in the parent-child menu chain more quickly and predictably. You can open items in batches by holding down `Alt`, and the menu will not close.

All new features are available through examples and a more detailed and intuitive main menu. It's now easier to understand how to use Radify!

## Submenus

Creating submenus is now easier:

```ahk
Radify.CreateMenu('mainMenu', [[
    {
        click: Submenu("Applications", appsMenu),
        rightClick: Submenu("Websites", websitesMenu, websitesMenuOptions),
        shiftClick: Submenu("Scripts", scriptsMenu),
        altClick: Submenu("Symbols", symbolMenu, symbolMenuOptions),
        ctrlClick: Submenu("Emoji", emojisMenu, emojisMenuOptions),
        text: 'Apps'   ; This is main item text
    }
]])
```

This example creates single item, that open "Applications" menu on left click, "Websites" on right click, "Scripts" on alt+click, "Emoji" on ctrl+click. One item - multiple actions.

You can create a submenu without a name. Also you can pass rings directly: 

```js
Submenu(, [[
    {image: 'autohotkey.ico', text: 'QuickSwitch'},
    {image: 'autohotkey beta.ico', text: 'Radify'},
    {image: 'aquahotkey.png', text: 'AquaHotkey'}
])
```

You can pass `Sub` just as before; it is now an alias for `Submenu`:

```js
click: Sub(, appsMenu),
```

The `submenu` item property is still supported, but has been superceed by `Submenu()` callback:

```js
Submenu(menuId := '', menuItems := '', options := {})
```

Each submenu can have its own set of options and unique name. The name you provided can be used anywhere:

```ahk

Radify.CreateMenu('mainMenu', [[
    {
        text: "destroyer2000",
        shiftClick: Submenu("apps", [[
            {
                click: App('notepad.exe')
            }
        ]]),
        click: () => Radify.CloseRoot("apps"),  ; close entire chain from "apps" to its root
        rightClick: () => Radify.CloseMenu("apps"),  ; close "apps" only
        pathFindHotkey: '^f',	 ; press Ctrl+F to open search window
        rootPathFind: 'apps',    ; starting searching from "apps"
    }
]])
```

In addition to various actions such as `shiftClick`, you can pass options that determine how the menu behaves after an item is clicked:

```js
{
    closeOnItemClick: false, 
    closeOnItemRightClick: false, 
    stayOpenOn: 'Alt'
}
```

By default, the menu closes automatically after you click on any item. `stayOpenOn` can be used to choose any key to hold down so that the menu **remains open**. This is useful for selecting multiple items at once and closing the menu when you release the key. *It can be any key, as long as it is compatible with GetKeyState()*.

## Auto Tooltip

If you've forgotten what happens when you `click`, `right-click`, or `shift-click`, enable the `autoTooltip` flag in the Skin Editor or in provide it in menu options. It can automatically generate both complex and simple tooltips describing the structure of menus and submenus:

```ahk
Radify.CreateMenu('mainMenu', [[
    {	; item
        click: Dir('Scripts\EmptyRecycleBin.ahk'), 
        rightClick: Dir(A_WinDir),
        text: 'Sys', 
        tooltip: 'my Sys item'
    }, 
    {   ; menu options         
        enableTooltip: true,
        autoTooltip: true,
        autoTooltipStructure: false, 
        autoTooltipMenuItemTextFirst: true,  ; append `text` property (if present)
        autoTooltipItemActionFirstOnly: false,  ; first found action of each menu or item (e.g. "click")
        autoTooltipMaxMenuItems: 2,  ; Max. amount from each menu and submenu
     }
]])
```

The following menu and submenu options allow you to customize the final appearance of the tooltip:

- `autoTooltip`: Generates the tooltip text if `tooltip` property is not present. Appends item text or image name: `my Sys item`

- `autoTooltipStructure`: Generates the tooltip from root Menu and Submenus structure: their text, items text, items actions actions (`click`, `rightClick`, ...):

  ```
  click: ./EmptyRecycleBin.ahk
  rightClick: ./System32
  ```

- `autoTooltipMenuItemTextFirst`: Append `text` property from each items. If `text` is missing, generate from actions and submenus.

  ```
  Sys  <-- text comes first
  click: ./EmptyRecycleBin.ahk
  rightClick: ./System32
  ```

- `autoTooltipItemActionFirstOnly`: Generate tooltip only from the first found action (`click`, `rightClick`, ...) of each menu or item: `click: ./EmptyRecycleBin.ahk`

- `autoTooltipMaxMenuItems`: If an action contains a submenu with many items, you can limit their number:

```
mainMenu
  click: menu "apps" <-- item1
  	 click: ./notepad.exe  
    click: ./notepad++.exe 
  click: menu "notes" <-- item2
  	 click: ./typora.exe 
    click: ./obsidian.exe
```

*Requests for better naming are appreciated.*

## Path Finding

In addition to automatically generating tooltips, Radify can help you find the element you're looking for by automatically navigating the entire path to it.

Since each submenu is now linked to its parent (and child, if any), Radify can precisely locate an item in any chain:

```
main menu -> submenu apps -> submenu notes -> ...
                      ^--- start here
```

In the Skin Editor or using the `rootPathFind` menu option, you can select the name of the menu from which to start the search. If an item is found in the submenus starting from this chain whose text matches the text entered in the search window, the mouse cursor will automatically trace the entire path from the root to the item and show you how to find it.

`rootPathFind` accepts a menu name (menuId) or a special placeholder:

- `<open>`: start the search from the currently open (visible) menu
- `<last>`: start the search from the last (recent) menu
- `<root>`: start the search from the root of the currently open menu

Menu options are responsible for configuring the Path Finding in the current menu and its child submenus:

```ahk
Radify.CreateMenu('mainMenu', [[
    {image: 'autohotkey.ico', text: 'QuickSwitch'},
    {image: 'autohotkey beta.ico', text: 'Radify'},
    {image: 'aquahotkey.png', text: 'AquaHotkey'}
]], 
{
	rootPathFind: '<open>',
    casePathFind: false,
   strictPathFind: false,
   pathFindHotkey: '^vk46',  ; Ctrl+F
})
```

- `rootPathFind`: The name of the Menu from which the path finding starts.
- `casePathFind`: Treat uppercase letters and lowercase letters as different (case-sens.) in item's `text`.
- `strictPathFind`: If the Item is not found in the chain starting from the root, an error will occur. Otherwise if the item was found in any other submenu in the parent-child chain, it will reveal it.
- `pathFindHotkey`: hotkey that opens search window, that expects item's `text` value to search for. *Must be compatible with the Hotkey() function*.

## Callbacks

Each predefined action was moved to a separate library *(not included by default)*:

- `Dir(path)` - will open any directory.

- `Fil(path)` - will open any file.

- `App(path)` - will open any file/application and activate it's window. If app is opened - just activates it's window.

- `Image(path, menuId, itemText, imagePath)` - will change image of item by it's `text` prop. inside `menuId` to `imagePath` and then will launch application `path` just like `App` above.

- `Cmd` - will execute a command in the background (uses `cmd.exe`).

- `Clip(toSend, isClipReverted := true, untilRevert := 300)` - will send passed data to the active window.

- `Extract(archivePath, workingDir?, exePath?)` - will extract the archive to `workingDir`. If `exePath` is provided - will launch that app. If `exePath` is relative, launches extracted app in `workinDir`.

<details><summary>How to create a callback</summary>

`click`, `rightClick`, ... expects a **callback** - something that can be called **later**. The easiest way to create a Radify-compatible callback is to implement the `ICallback` interface:

```js
class Temp extends ICallback {
    Call() => Run(A_Temp)
}
```

A callback must have a `Call()` method. The `ToString()` method is optional, and used by tooltip auto-gen. to convert an action such as `click` into a string for the tooltip:

```js
class Dir extends ICallback {
    __New(path) {
        this.path := path
        this.file := GetName(path)
    }
    Call() => Run(this.path)
    ToString() => this.file
}
```

The `__New` constructor is only needed so that the callback can store information required for the `Call()` method to function.

Various callbacks are already provided in the library, and their `ToString()` methods return a human-readable value for tooltip auto-gen.

</details>

## Safety

- All actions now require a function or an object with a `Call()` method: `click`, `rightClick`, `shiftClick`, `altClick`, `ctrlClick`, `menuClick`, `menuRightClick`, `centerClick`, `centerRightClick`.

  - You can pass one of the predefined strings: `Close`, `CloseMenu`, `Drag`.

  - To disable an action, explicitly pass an empty string `""` or `"None"`.

  - Any other string will be considered an error.

- All action triggers now require a compatible value:

  - Hotkey/key/shortcut compatible with `Hotkey()`: `HotkeyClick`, `HotkeyRightClick`, `HotkeyShiftClick`, `HotkeyAltClick`, `HotkeyCtrlClick`.
  - Hotstring compatible with `Hotstring()`: `HotstringClick`, `HotstringRightClick`, `HotstringShiftClick`, `HotstringAltClick`, `HotstringCtrlClick`.
  - Hidden registration errors or incorrect values are now displayed. Unexpected triggering or accidental activation is prevented.

- Some silent or hidden errors are now made explicit. This will prevent unexpected menu behavior.

- Performance has been improved.

<details><summary>New API</summary>

#### Methods

- `ShowLast()` - displays last opened menu or submenu.
- `EnumerateActions(menuItem, prefix, trigger, firstOnly)` - collects all `(name, action)` pairs from `menuItem` like `click`, `rightClick`, ... and returns them as `Map`. *You can extend it's implementation to add new modifiers like `Space` or `Win`.*
- `ItemToString(menuItem, textFirst, firstActionOnly)` - collects all "name: action" pairs from `menuItem`, optionally prepends them with `text` value, and returns them as string. *Used by `autoTooltipStructure`.*
- `MenuToString(menuId, textFirst, firstActionOnly, limit)` - collects text/actions from items in the menu by with `menuId` and returns "menu <menuID> <data>" string.
- `SubMenuToString(menuId, textFirst := true, limit := 2)` - same as above, but collects data only from the 1st level of the submenu, without deep searching. *`Submenu.ToString()` uses this API method.*

#### Properties

- `indentationLevel`: amount of spaces before each subsequent menu, submenu or item's data, returned from `ItemToString`, `MenuToString`, `SubMenuToString` and `Submenu.ToString()`. Doubles for each new nested item/submenu. *Edit it to change generated tooltip appearance.*

- `lastMenuOpenInfo`: stores information about last opened menu or submenu - `id`, `mouseX`, `mouseY`, `hwndUnderMouse`. *Override it to change Path Finding and `ShowLast()` behavior.*

- `lastFoundInfo`: stores information about the menu, found recently by Path Finding - `itemText`, `menuId`. *Override it to change Path Finding behavior and text in the search window.*

  </details>
