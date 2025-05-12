userprofile := EnvGet("USERPROFILE")

#1::
{
	if WinExist("ahk_exe WindowsTerminal.exe")
		WinActivate
	else
		Run(userprofile "\AppData\Local\Microsoft\WindowsApps\wt.exe")
    	return
}

#2::
{
	if WinExist("ahk_exe msedge.exe")
		WinActivate
	else
		Run("C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
    	return
}

#3::
{
	if WinExist("ahk_exe Cursor.exe")
		WinActivate
	else
		Run("C:\Users\hiros\AppData\Local\Programs\cursor\Cursor.exe")
    	return
}

*vkBA::
{
    If (GetKeyState("Shift")){
        Send "`;"
    }
    else {
        Send ":"
    }
}
