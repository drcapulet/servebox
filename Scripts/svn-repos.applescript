-- svn-repos.applescript
-- ServeBox

--  Created by Alex Coomans on 6/30/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.
if visible of window "managerepos" is false then
	set visible of window "managerepos" to true
	tell window "managerepos"
		activate
	end tell
end if
do shell script "/Applications/servebox/services/subversion/bin/svn list file:///Applications/servebox/services/repos/mainrepo"
set _Result to the result
set the contents of text view "svnrepos" of scroll view "svnrepos" of window "managerepos" to _Result
do shell script "ls /Applications/servebox/services/repos"
set tresult to the result --as text
--display dialog tresult
set rows to the number of words of tresult
tell menu of popup button "dropdown" of window "managerepos"
	delete every menu item
	repeat with I from 1 to rows
		set rname to (get word I of tresult)
		make new menu item at the end of menu items with properties {title:rname}
		set title of menu item I to rname
	end repeat
	--make new menu item at the end of menu items with properties {separator item:true, title:"sep"}
	
	set addname to "Add new..."
	make new menu item at the end of menu items with properties {title:addname}
end tell

--set contents of popup button "dropdown" to tresult

on clicked theObject
	if the name of theObject is "add" then
		set reponame to the title of the current menu item of popup button "dropdown" of window "managerepos"
		
		display dialog "What would you like to name your project? No space are allowed." default answer "" with icon 1
		set projectname to the text returned of the result
		if projectname contains " " then
			display dialog "Your project name contains spaces. Please choose a different name." with icon 1
		else
			--set reponame to selected menu item of menu "dropdown"
			--display dialog "cd /tmp; mkdir " & projectname & "; cd " & projectname & "; mkdir branches; mkdir tags; mkdir trunk; cd /tmp; svn import project file:///tmp/" & projectname & " -m '" & projectname & " project import';"
			do shell script "cd /tmp; mkdir " & projectname & "; cd " & projectname & "; mkdir branches; mkdir tags; mkdir trunk; cd /tmp; /Applications/servebox/services/subversion/bin/svn import " & projectname & " file:///Applications/servebox/services/repos/" & reponame & "/" & projectname & " -m '" & projectname & " project import';"
			my refresh(reponame)
		end if
		
	end if
	if the name of theObject is "remove" then
		display dialog "What is the name of the project you would like to delete?" default answer "" with icon 1
		set delprojectname to the text returned of the result
		display dialog "Are you shure you want to delete the project " & delprojectname & " ?" with icon 1
		if delprojectname contains " " then
			display dialog "Your project name contains spaces. Please choose a different name." with icon 1
		else
			set reponame to the title of the current menu item of popup button "dropdown" of window "managerepos"
			
			do shell script "/Applications/servebox/services/subversion/bin/svn delete -m 'Deleting " & delprojectname & " project dir' file:///Applications/servebox/services/repos/" & reponame & "/" & delprojectname
			my refresh(reponame)
		end if
	end if
	if the name of theObject is "refresh" then
		set reponame to the title of the current menu item of popup button "dropdown" of window "managerepos"
		my refresh(reponame)
	end if
end clicked

on choose menu item theObject
	if the title of the current menu item of popup button "dropdown" of window "managerepos" is "Add new..." then
		display dialog "What would you like to name your repository? No spaces are allowed." default answer "" with icon 1
		set reponame to the text returned of the result
		if reponame contains " " then
			display dialog "Your repository name contains spaces. Please choose a different name." with icon 1
		else
			--set reponame to selected menu item of menu "dropdown"
			--display dialog "cd /tmp; mkdir " & projectname & "; cd " & projectname & "; mkdir branches; mkdir tags; mkdir trunk; cd /tmp; svn import project file:///tmp/" & projectname & " -m '" & projectname & " project import';"
			do shell script "mkdir /Applications/servebox/services/repos/" & reponame & "; /Applications/servebox/services/subversion/bin/svnadmin create /Applications/servebox/services/repos/" & reponame
			my refresh(reponame)
			my refreshMenu()
			delay 1
			(*
			tell menu of popup button "dropdown" of window "managerepos"
				set current menu item to menu item reponame
			end tell*)
		end if
		
	else
		set reponame to the title of the current menu item of popup button "dropdown" of window "managerepos"
		my refresh(reponame)
	end if
end choose menu item

on refresh(reponame)
	do shell script "/Applications/servebox/services/subversion/bin/svn list file:///Applications/servebox/services/repos/" & reponame
	set the contents of text view "svnrepos" of scroll view "svnrepos" of window "managerepos" to the result
end refresh

on refreshMenu()
	do shell script "ls /Applications/servebox/services/repos"
	set tresult to the result --as text
	--display dialog tresult
	set rows to the number of words of tresult
	tell menu of popup button "dropdown" of window "managerepos"
		delete every menu item
		repeat with I from 1 to rows
			set rname to (get word I of tresult)
			make new menu item at the end of menu items with properties {title:rname}
			set title of menu item I to rname
		end repeat
		--make new menu item at the end of menu items with properties {separator item:true, title:"sep"}
		
		set addname to "Add new..."
		make new menu item at the end of menu items with properties {title:addname}
	end tell
end refreshMenu
