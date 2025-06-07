userprofile := EnvGet("USERPROFILE")

#1::
{
	if WinExist("ahk_exe wezterm-gui.exe")
		WinActivate
	else
		Run("C:\Program Files\WezTerm\wezterm-gui.exe")
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
	if WinExist("ahk_exe Code.exe")
		WinActivate
	else
		Run(userprofile "\AppData\Local\Programs\Microsoft VS Code\Code.exe")
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

