class ICallback {
    name := this.__Class
    
    Call() {
        throw MethodError('not implemented')
    }
    
    ToString() => ((this.Name || '(unnamed)') . '()')
}

Func.Prototype.DefineProp('ToString', {
    call: (this) => ((this.Name || '(unnamed)') . '()')
})