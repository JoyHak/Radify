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