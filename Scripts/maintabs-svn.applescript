-- maintabs-svn.applescript
-- ServeBox

--  Created by Alex Coomans on 6/30/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.

set svninstalled to 0
try
	do shell script "/Applications/servebox/services/subversion/bin/svn --version"
	set _Result to the result
	if _Result contains "version" then
		set svninstalled to 1
	end if
on error e number n
	if e contains "command not found" then
		set svninstalled to 0
	else
		display dialog "Error. It seems that we had trouble finding wheter or not Subversion was installed. Please report this bug to the developer." with icon 0
		set svninstalled to 3
	end if
end try

if svninstalled is 0 then
	set visible of scroll view "svninstalled" of tab view item "svntab" of tab view "maintabs" of window "servebox" to true
	display dialog "We did not detect that Subversion is installed. You can install it by downloading the servebox installer and installing it." buttons {"OK"} default button 1 with icon 1
end if
if svninstalled is 3 then
	set visible of scroll view "svninstalled" of tab view item "svntab" of tab view "maintabs" of window "servebox" to true
end if

on clicked theObject
	if the name of theObject is equal to "reposbtn" then
		--display dialog "This feature is coming soon." buttons {"OK"} default button 1 with icon 1
		run script (((path to me) as string) & "Contents:Resources:Scripts:svn-repos.scpt") as alias
	end if
	if the name of theObject is equal to "websvnbtn" then
		--display dialog "This feature is coming soon." buttons {"OK"} default button 1 with icon 1
		--set websvninstalled to "false"
		tell application "Finder"
			if (exists "/Applications/servebox/htdocs/websvn" as POSIX file) then
				tell application "loginwindow" to open location "http://127.0.0.1/websvn/"
			else
				my runWebSvnDownload()
			end if
		end tell
		--my runWebSvnDownload()
		
	end if
	if the name of theObject is "okbutton" then
		if visible of window "downloadingwebsvn" is true then
			set visible of window "downloadingwebsvn" to false
		end if
	end if
end clicked

on runWebSvnDownload()
	--set websvninstall to display dialog "WebSVN is not installed. Would you like to install it or cancel?" buttons {"Cancel", "Install"} default button 2 with icon 1 attached to window "servebox"
	--display dialog websvninstall
	display dialog "WebSVN is not installed. Would you like to install it or cancel?" buttons {"Cancel", "Install"} default button 2 with icon 1 --attached to window "servebox"
	--set the button_pressed to the button returned of the result
	if the button returned of the result is "Install" then
		--if the button returned of the result is "Install" then
		-- Show Downloading window
		set downloadingwebsvn to window "downloadingwebsvn"
		display panel downloadingwebsvn attached to window "servebox"
		
		(*====
		if visible of window "downloadingwebsvn" is false then
			set visible of window "downloadingwebsvn" to true
			tell window "downloadingwebsvn"
				activate
			end tell
		end if====*)
		--set font of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to call method "fontWithName:size:" of class "NSFont" with parameters {"Lucida Grande", 13}
		--set font of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to call method "fontWithName:size:" of class "NSFont" with parameters {"Lucida Grande", 13}
		--set color of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to call method "whiteColor" of class "NSColor"
		--set color of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to call method "whiteColor" of class "NSColor"
		
		
		-- Start Progress
		start progress indicator "progress" of window "downloadingwebsvn"
		-- Start Download of WebSVN
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Downloading WebSVN"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 1 of 5"
		
		set the contents of progress indicator "progress" of window "downloadingwebsvn" to 0
		--tell application "Terminal"
		--do script "curl -# http://websvn.tigris.org/files/documents/1380/39378/websvn-2.0.tar.gz > /Applications/servebox/htdocs/websvn.tar.gz; cd /Applications/servebox/htdocs; tar xvfz websvn.tar.gz; mv websvn-2.0 websvn"
		--delay 3
		--quit
		--end tell
		do shell script "cd /Applications/servebox/htdocs; curl -# -O http://websvn.tigris.org/files/documents/1380/39378/websvn-2.0.tar.gz >& /Applications/servebox/support_files/downloads/websvnprog.txt &"
		delay 1
		try
			set doc1 to POSIX file "/Applications/servebox/support_files/downloads/websvnprog.txt"
			set progtext to read file doc1
			set progress to (get last word of progtext)
			--repeat
			repeat until progress contains "100"
				set doc1 to POSIX file "/Applications/servebox/support_files/downloads/websvnprog.txt"
				set progtext to read file doc1
				--set progress to (get last paragraph of progtext)
				set progress to (get last word of progtext)
				set the contents of progress indicator "progress" of window "downloadingwebsvn" to progress
			end repeat
			
		on error
			set indeterminate of progress indicator "progress" of window "downloadingwebsvn" to true
			start progress indicator "progress" of window "downloadingwebsvn"
			
			delay 5
			try
				set indeterminate of progress indicator "progress" of window "downloadingwebsvn" to false
				set doc1 to POSIX file "/Applications/servebox/support_files/downloads/websvnprog.txt"
				set progtext to read file doc1
				set progress to (get last word of progtext)
				--repeat
				repeat until progress contains "100"
					set doc1 to POSIX file "/Applications/servebox/support_files/downloads/websvnprog.txt"
					set progtext to read file doc1
					--set progress to (get last paragraph of progtext)
					set progress to (get last word of progtext)
					set the contents of progress indicator "progress" of window "downloadingwebsvn" to progress
				end repeat
			on error
				delay 20
				set indeterminate of progress indicator "progress" of window "downloadingwebsvn" to false
				set doc1 to POSIX file "/Applications/servebox/support_files/downloads/websvnprog.txt"
				set progtext to read file doc1
				set progress to (get last word of progtext)
				--repeat
				repeat until progress contains "100"
					set doc1 to POSIX file "/Applications/servebox/support_files/downloads/websvnprog.txt"
					set progtext to read file doc1
					--set progress to (get last paragraph of progtext)
					set progress to (get last word of progtext)
					set the contents of progress indicator "progress" of window "downloadingwebsvn" to progress
				end repeat
				
			end try
		end try
		delay 1
		
		-- Untar & rename websnv
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Installing WebSVN"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 2 of 5"
		
		set the contents of progress indicator "progress" of window "downloadingwebsvn" to 0
		do shell script "cd /Applications/servebox/htdocs; tar xvfz websvn-2.0.tar.gz; mv websvn-2.0 websvn"
		delay 1
		set the contents of progress indicator "progress" of window "downloadingwebsvn" to 100
		
		-- Download conf file
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Downloading configuration file"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 3 of 5"
		set the contents of progress indicator "progress" of window "downloadingwebsvn" to 0
		do shell script "cd /Applications/servebox/htdocs/websvn/include; curl -O http://www.alexcoomans.net/servebox/services/websvn/config.tar.gz"
		--tell application "Terminal"
		--do script "curl -# http://www.alexcoomans.net/servebox/appcast/updates/servebox_1.0beta.zip > /Users/alex/Desktop/test.zip"
		--do script "curl -# -O http://www.alexcoomans.net/servebox/appcast/updates/servebox_1.0beta.zip > /Users/alex/Desktop/test.zip >& /Applications/servebox/support_files/downloads/websvnconfprog.txt"
		--delay 2
		--quit
		--end tell
		set the contents of progress indicator "progress" of window "downloadingwebsvn" to 100
		
		-- get percent
		delay 0.5
		
		(*====
		set doc1 to POSIX file "/Applications/servebox/support_files/downloads/websvnconfprog.txt"
		set progtext to read file doc1
		set progress to (get last word of progtext)
		--repeat
		repeat until progress contains "100"
			set doc1 to POSIX file "/Applications/servebox/support_files/downloads/websvnconfprog.txt"
			set progtext to read file doc1
			--set progress to (get last paragraph of progtext)
			set progress to (get last word of progtext)
			set the contents of progress indicator "progress" of window "downloadingwebsvn" to progress
		end repeat ====*)
		
		-- Install conf file
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Installing configuration file"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 4 of 5"
		set the contents of progress indicator "progress" of window "downloadingwebsvn" to 0
		do shell script "cd /Applications/servebox/htdocs/websvn/include; tar xvfz config.tar.gz"
		delay 1
		set the contents of progress indicator "progress" of window "downloadingwebsvn" to 100
		-- Finish
		delay 1
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Finishing"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 5 of 5"
		set the contents of progress indicator "progress" of window "downloadingwebsvn" to 0
		do shell script "cd /Applications/servebox/htdocs; rm websvn-2.0.tar.gz"
		set the contents of progress indicator "progress" of window "downloadingwebsvn" to 50
		do shell script "cd /Applications/servebox/htdocs/websvn/include; rm config.tar.gz"
		set the contents of progress indicator "progress" of window "downloadingwebsvn" to 100
		
		stop progress indicator "progress" of window "downloadingwebsvn"
		-- Set hidden to true on ok button
		set enabled of button "okbutton" of window "downloadingwebsvn" to true
	end if
end runWebSvnDownload