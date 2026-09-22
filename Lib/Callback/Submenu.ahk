/**
 * Creates a menu with the specified `menuId` and structure according to `params` (see {@link Radify.CreateMenu})
 * @author Rafaello
 * @license MIT
 * @see {@link https://github.com/JoyHak/Radify#submenuid-params GitHub}
 * @see {@link Radify#ProcessActions}
 * @see {@link Radify#ProcessSubmenu}
 * @param {string} menuId - Unique identifier of the menu (optional, will be auto-generated).
 * @param {array} menuItems - Array of array with objects, that represents items.
 * @param {object} options - Configuration options for the menu (same as {@link Radify#CreateMenu})
 */
class Submenu extends ICallback {
    __New(menuId := '', menuItems := '', options := {}) {
        ; Values assigned by Radify#ProcessActions
        this.menuId     := menuId
        this.menuItems  := menuItems
        this.options    := options
    }

    ToString() => Radify.SubMenuToString(
        this.menuId,
        this.options.autoTooltipMenuItemTextFirst,
        this.options.autoTooltipMaxMenuItems
    )
}

class Sub extends Submenu {
}