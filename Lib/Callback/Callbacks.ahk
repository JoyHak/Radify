#include ICallback.ahk

GetName(path) {
    SplitPath(path, , , , &base)
    return base
}

GetFileName(path) {
    SplitPath(path, &name)
    return name
}

/**
 * Creates "open directory" (folder) callback.
 */
class Dir extends ICallback {
    __New(path) {
        this.path := path
        this.file := GetName(path)
    }
    
    Call() => Run(this.path)
    
    ToString() => './' . this.file
}

/**
 * Creates "open file" callback. `File` name is reserved: it is built-in object.
 */
class Fil extends Dir {
    __New(path) {
        super.__New(path)
        this.file := GetFileName(path)
    }
}

/**
 * Creates "run application" (executable) callback.
 */
class App extends ICallback {
    __New(path) {
        this.path := path
        this.file := GetName(path)
        this.WinTitle := 'ahk_exe ' . this.file . '.exe'
    }
    
    Call() {
        if (hwnd := WinExist(this.WinTitle)) {
            WinShow(hwnd)
            WinActivate(hwnd)
            return
        } 
        
        try {
            Run(this.path)            
        } catch as e {
            Radify.OnError(e)
        }
    }
    
    ToString() => this.file
}

/**
 * Creates "run app and change item image" callback.
 * @see {@link Radify#SetItemImage}
 * @param {string} menuId    Unique identifier of the menu.
 * @param {string} itemText  The value of the `text` property for the item object that needs to be found in the menu.
 * @param {string} imagePath Full path to the new image or image filename, see {@link Radify#SetImageDir}.
 */
class Image extends App {
    __New(path, menuId, itemText, imagePath) {
        super.__New(path)
        this.SetImage := 
            Radify.SetItemImage.Bind(Radify, menuId, itemText, imagePath)
            
        this.image := GetFileName(imagePath)
    }
    
    Call() {
        super()
        this.SetImage()
    }
    
    ToString() => (super.ToString() . '`nImage -> ' . this.image)
}

/**
 * Creates "run console command" callback.
 */
 class Cmd extends ICallback {
    __New(commandLine) {
        this.cmd  := commandLine
    }
    
    Call() => Run(A_ComSpec ' /c ' this.cmd, , 'hide')
    
    ToString() => '``' . this.cmd . '``'
}


/**
 * Creates callback, that extracts archive to the target directory and launches 
 * specified application (optionally).
 * @param {String} archivePath  Full/relative path to the archive.
 * @param {String?} workingDir  Full/relative path to directory in which archive would be extracted.
 *                              If not specified, `A_Temp\<archiveBase>` would be used.
 * @param {String?} exePath     Path to the app. Full or relative to the `workingDir`.
 *                              If not specified, simply extracts archive.
 */
class Extract extends ICallback {
    __New(archivePath, workingDir?, exePath?) {
        this.archive := archivePath
        this.exe     := exePath ?? ''
        this.file    := GetName(this.exe) 
        this.workDir := workingDir ?? (A_Temp . '\' . this.file)
    }
    
    Call() {
        RunWait('"C:\Program Files\7-Zip\7zG.exe" x "-air!' this.archive '" -an -sae -o"' this.workDir '"')
        
        if !this.exe
            return
        
        static processQuery := 
        (Join`s
           "select processId, commandLine 
            from Win32_Process 
            where CommandLine like '%" this.file "%'"
        )
        
        for p in ComObjGet("winmgmts:").ExecQuery(processQuery) {
            if !InStr(p.commandLine, this.exe)
                continue
                
            ProcessClose(p.processId)
            ProcessWaitClose(p.processId, 4)
        }
        
        exe := FileExist(this.exe) 
             ? this.exe
             : this.workDir . '\' . this.exe
        
        Run(this.exe, this.workDir)
        Run(this.workDir)
    }
    
    ToString() => 'extract ./' . GetFileName(this.archive)  . ' and run ' . this.exe
}