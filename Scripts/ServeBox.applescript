-- ServeBox.applescript
-- ServeBox

--  Created by Alex Coomans on 6/9/08.
--  Copyright 2008 Alex Coomans. All rights reserved.

--tell progress indicator "progress" of window "plugins" to start
--set visible of window "servebox" to true
--tell window "servebox" to activate
tell window "plugins" to activate
on choose menu item theObject
	if the name of theObject is equal to "prefmenu" then
		run script (((path to me) as string) & "Contents:Resources:Scripts:prefs.scpt") as alias
	end if
	(*====
	if the name of theObject is equal to "servicesutil" then
		tell application "serveboxutilityapp"
			activate
		end tell
	end if====*)
	if the name of theObject is "reportbug" then
		--tell application "loginwindow" to open location "http://servebox.alexcoomans.net/bugtracker/"
		run script (((path to me) as string) & "Contents:Resources:Scripts:detect-plugins.scpt") as alias
	end if
	if the name of theObject is "statushud" then
		run script (((path to me) as string) & "Contents:Resources:Scripts:servicesstatus.scpt") as alias
	end if
	if the name of theObject is "sbsite" then tell application "loginwindow" to open location "http://servebox.alexcoomans.com"
	if the name of theObject is "forums" then tell application "loginwindow" to open location "http://software.alexcoomans.com/forum/"
end choose menu item


on should quit after last window closed theObject
	return true
end should quit after last window closed

on launched theObject
	tell window of theObject to center
	tell progress indicator "progress" of window "plugins" to start
end launched

on reopen
	if visible of window "serveboxmain" is false then
		set visible of window "serveboxmain" to true
		tell window "serveboxmain"
			activate
		end tell
	end if
	
end reopen


on clicked theObject
	if the name of theObject is equal to "modulesbutton" then
		run script (((path to me) as string) & "Contents:Resources:Scripts:versions.scpt") as alias
	end if
	if the name of theObject is equal to "apachebutton" then
		tell tab view "maintabs" of window "servebox"
			set current tab view item to tab view item "apachetab"
			run script (((path to me) as string) & "Contents:Resources:Scripts:maintabs-apache.scpt") as alias
		end tell
	end if
	if the name of theObject is equal to "phpbutton" then
		tell tab view "maintabs" of window "servebox"
			set current tab view item to tab view item "phptab"
			run script (((path to me) as string) & "Contents:Resources:Scripts:maintabs-php.scpt") as alias
		end tell
	end if
	if the name of theObject is equal to "mysqlbutton" then
		tell tab view "maintabs" of window "servebox"
			set current tab view item to tab view item "mysqltab"
			run script (((path to me) as string) & "Contents:Resources:Scripts:maintabs-mysql.scpt") as alias
		end tell
	end if
	if the name of theObject is equal to "svnbutton" then
		tell tab view "maintabs" of window "servebox"
			set current tab view item to tab view item "svntab"
			run script (((path to me) as string) & "Contents:Resources:Scripts:maintabs-svn.scpt") as alias
		end tell
	end if
	if the name of theObject is "showmainwindow" then
		if visible of window "serveboxmain" is false then
			set visible of window "serveboxmain" to true
			tell window "serveboxmain"
				activate
			end tell
		end if
	end if
	
end clicked


