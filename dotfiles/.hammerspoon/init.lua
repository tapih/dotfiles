local function launchOrRaise(appName, appPath)
	local app = hs.application.find(appName)
	if app then
		app:activate()
	else
		hs.application.launchOrFocus(appPath or appName)
	end
end

local hyper = { "ctrl", "alt" }

hs.hotkey.bind(hyper, "1", function()
	launchOrRaise("Slack", "/Applications/Slack.app")
end)

hs.hotkey.bind(hyper, "2", function()
	launchOrRaise("Google Chrome", "/Applications/Google Chrome.app")
end)

hs.hotkey.bind(hyper, "3", function()
	launchOrRaise("Alacritty", "/opt/homebrew/bin/alacritty"
end)
