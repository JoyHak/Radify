/**
 * Creates a menu with the specified `menuId` and structure according to `params` (see {@link Radify.CreateMenu})
 * @author Rafaello
 * @license MIT
 * @see {@link https://github.com/JoyHak/Radify#submenuid-params GitHub}
 * @param {string} menuId - Unique identifier of the menu. Unique random number by default.
 * @param {object} options - Configuration options for the menu (same for {@link Radify.CreateMenu})
 */
class Sub {
    __New(menuId := '', params*) {
        lastErr := Error('Provide a unique menuId for submenu', 'CreateMenu', Json.Stringify(params))
        isIntialized := false
        
        loop 3 {
            if !menuId
                menuId := A_Now . Random(0, 10000) . params.length
                
            try {
                Radify.CreateMenu(menuId, params*) 
                
                this.menuId  := menuId
                this.params  := params
                isIntialized := true
                break
            } catch as e {
                e.extra .= ' ' lastErr.extra ' '
                lastErr := e
            }
        }
        
        if !isIntialized {
            Radify.OnError(lastErr, menuId)
            Exit()
        }
    }
    
    Call() {
        return Radify.Show(this.menuId)
    }   
}