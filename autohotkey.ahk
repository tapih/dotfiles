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
	if WinExist("ahk_exe Slack.exe")
		WinActivate
	else
		Run("Slack.exe")
    	return
}

#3::
{
	if WinExist("ahk_exe msedge.exe")
		WinActivate
	else
		Run("C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")
    	return
}

#4::
{
	if WinExist("ahk_exe Code.exe")
		WinActivate
	else
		Run(userprofile "\AppData\Local\Programs\Microsoft VS Code\Code.exe")
    	return
}


