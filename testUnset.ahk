#Requires AutoHotkey v2
#Warn

obj  := {
    a: 0
}

MsgBox(obj.a . ' ' . (obj.b ?? 1))