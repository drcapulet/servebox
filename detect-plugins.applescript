-- detect-plugins.applescript
-- ServeBox

--  Created by Alex Coomans on 8/2/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.
(*
do shell script "ls /Applications/servebox/services/plugins"
set plugingroups to the result
set numgroups to the number of paragraphs in plugingroups
if numgroups > 0 then
	repeat with I from 1 to numgroups
		set plugingroupname to paragraph I of plugingroups
		--do shell script "cd /Applications/servebox/services/plugins/" & plugingroupname
		do shell script "ls /Applications/servebox/services/plugins/" & plugingroupname
		
		set pluginnames to the result
		set numplugins to the number of paragraphs in pluginnames
		repeat with I from 1 to numplugins
			set pluginexecname to paragraph I of pluginnames
			do shell script "defaults read /Applications/servebox/services/plugins/" & plugingroupname & "/" & pluginexecname & "/Contents/" & pluginexecname & "-Info CFBundleIconFile"
			set imageiconfile to the result
			set newImage to load image imageiconfile
			set imagebutton to button ("button" & I & "-" & plugingroupname)
			call method "setImage:" of imagebutton with parameter newImage
			
		end repeat
	end repeat
end if *)
global imagenew
global imageiconfile
global imageiconfile1

-- script
do shell script "ls /Applications/servebox/services/plugins"
set plugingroups to the result
set numgroups to the number of paragraphs in plugingroups
--display dialog plugingroups
if numgroups > 0 then
	repeat with currentgroup from 1 to numgroups
		set plugingroupname to paragraph currentgroup of plugingroups
		--do shell script "cd /Applications/servebox/services/plugins/" & plugingroupname
		do shell script "ls /Applications/servebox/services/plugins/" & plugingroupname
		set pluginnames to the result
		set groupheadername to "groupheader" & currentgroup
		--display dialog groupheadername
		--display dialog plugingroupname
		set the contents of text field groupheadername to plugingroupname
		--set groupheadernametitle to (text field groupheadername of window "servebox")
		--set title of groupheadernametitle to plugingroupname
		--set visible of "sepg" & currentgroup & "1" to true
		
		
		set numplugins to the number of paragraphs in pluginnames
		repeat with I from 1 to numplugins
			set pluginexecname to paragraph I of pluginnames
			--display dialog pluginexecname
			set sbplugin to "/Applications/servebox/services/plugins/" & plugingroupname & "/" & pluginexecname
			--set sbplugin to (choose folder with prompt "Choose an sbplugin")
			--set pluginname to name of (info for sbplugin)
			--tell application "Finder" to set group1 to container of sbplugin as text
			--tell application "Finder" to set groupname to POSIX path of group1
			--set groupname to name of (info for (POSIX file groupname))
			--tell application "System Events" to set sbplugin1 to POSIX path of sbplugin
			set resourcepath to sbplugin & "/Contents/Resources/"
			tell application "System Events"
				set sourceplist to sbplugin & "/Contents/Info.plist"
				set iconfile to (value of property list item "SBIcon" of property list file sourceplist)
				set mainnib to (value of property list item "SBMainNIB" of property list file sourceplist)
				set windowname to (value of property list item "SBMainWindow" of property list file sourceplist)
				set mainscript to (value of property list item "SBMainCode" of property list file sourceplist)
				set sbname to (value of property list item "SBName" of property list file sourceplist)
			end tell
			display dialog "Plugin Name: " & pluginexecname & "
Group Name: " & plugingroupname & "
Resource Path: " & resourcepath & "
Icon File: " & iconfile & "
Main NIB: " & mainnib & "
Window Name: " & windowname & "
Main Script: " & mainscript
			--display dialog resourcepath & iconfile
			set imageiconfile to resourcepath & iconfile
			--set imageiconfile to POSIX path of imageiconfile
			--set newImage to load image imageiconfile
			--display dialog "g" & currentgroup & "b" & I
			set imagebutton to button ("g" & currentgroup & "b" & I) of tab view item "hometab" of tab view "maintabs" of window "servebox"
			--display dialog imageiconfile
			--call method "setImage:" of imagebutton with parameter newImage
			set imagenew to "a"
			set imagenew to load image imageiconfile --"applications.png"
			--display dialog imagenew
			call method "setImage:" of imagebutton with parameter imagenew
			set title of imagebutton to sbname
			set enabled of imagebutton to true
		end repeat
	end repeat
end if