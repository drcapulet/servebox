-- mysqlpw.applescript
-- ServeBox

--  Created by Alex Coomans on 7/5/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.

if visible of window "mysqlpw" is false then
	set visible of window "mysqlpw" to true
	tell window "mysqlpw"
		activate
	end tell
end if
set mysqlrunning to 0
my checkMysqlRunning(mysqlrunning)


on clicked theObject
	if the name of theObject is "rootbtn" then
		tell user defaults
			if default entry "mysqlrootpwchanged" exists then
				set rootpwchanged to contents of default entry "mysqlrootpwchanged"
			else
				set rootpwchanged to 0
			end if
		end tell
		--display dialog rootpwchanged
		if rootpwchanged is 0 then
			
			display dialog "Please enter the new password for the root mysql account. You will need it frequently." default answer "" buttons {"Cancel", "OK"} default button 2 with icon 1
			set newpw to the text returned of the result
			--set button_pressed to the button returned of the result
			display dialog "You are going to set your new password for the MySQL root account to: " & newpw & ". Is this correct?" with icon 1
			if button returned of the result is "OK" then
				tell application "Terminal"
					do script "cd /Applications/servebox/services/mysql; bin/mysqladmin -u root password " & newpw & ""
				end tell
				display dialog "The password for the MySQL root account is now " & newpw & ". Please keep this in a safe place." buttons {"OK"} default button 1 with icon 1
			end if
			set rootchanged to 1
			tell user defaults
				if default entry "mysqlrootpwchanged" exists then
					set contents of default entry "mysqlrootpwchanged" to rootchanged
				else
					make new default entry at end of default entries with properties {name:"mysqlrootpwchanged", contents:rootchanged}
				end if
			end tell
		else
			--if rootpwchanged is 1 then display dialog "true"
			
			display dialog "Please enter the existing password for the root mysql account." default answer "" buttons {"Cancel", "OK"} default button 2 with icon 1
			set oldpw to the text returned of the result
			display dialog "Please enter the new password for the root mysql account. You will need it frequently." default answer "" buttons {"Cancel", "OK"} default button 2 with icon 1
			set newpw to the text returned of the result
			--set button_pressed to the button returned of the result
			display dialog "You are going to set your new password for the MySQL root account to: " & newpw & ". Is this correct?" with icon 1
			if button returned of the result is "OK" then
				tell application "Terminal"
					do script "cd /Applications/servebox/services/mysql; bin/mysqladmin -u root -p password " & newpw & ""
				end tell
				display dialog "Please enter your existing password in Terminal and hit enter. Then press continue" buttons {"Continue"} default button 1 with icon 1
				display dialog "The password for the MySQL root account is now " & newpw & ". Please keep this in a safe place." buttons {"OK"} default button 1 with icon 1
			end if
			set rootchanged to 1
			tell user defaults
				if default entry "mysqlrootpwchanged" exists then
					set contents of default entry "mysqlrootpwchanged" to rootchanged
				else
					make new default entry at end of default entries with properties {name:"mysqlrootpwchanged", contents:rootchanged}
				end if
			end tell
			
		end if
		
		
		
		
		(*====
		--set visible to true
		if visible of window "changepwdialog" is false then
			set visible of window "changepwdialog" to true
			tell window "changepwdialog"
				activate
			end tell
		end if
		--set font of text view "changing" of scroll view "changing" of window "downloadingwebsvn" to call method "fontWithName:size:" of class "NSFont" with parameters {"Lucida Grande", 13}
		--set color of text view "changing" of scroll view "changing" of window "downloadingwebsvn" to call method "whiteColor" of class "NSColor"
		set the contents of text view "changing" of scroll view "changing" of window "changepwdialog" to "Change the password for the root account:"
		set username to "root" ====*)
	end if
	if the name of theObject is "mysqlbtn" then
		--set visible to true
		tell user defaults
			if default entry "mysqlmysqlpwchanged" exists then
				set mysqlpwchanged to contents of default entry "mysqlmysqlpwchanged"
			else
				set mysqlpwchanged to 0
			end if
		end tell
		if mysqlpwchanged is 0 then
			display dialog "Please enter the new password for the mysql mysql account. You will need it frequently." default answer "" buttons {"Cancel", "OK"} default button 2 with icon 1
			set newpw to the text returned of the result
			--set button_pressed to the button returned of the result
			display dialog "You are going to set your new password for the MySQL mysql account to: " & newpw & ". Is this correct?" with icon 1
			if button returned of the result is "OK" then
				
				display dialog "The password for the MySQL mysql account is now " & newpw & ". Please keep this in a safe place." buttons {"OK"} default button 1 with icon 1
			end if
			set mysqlchanged to 1
			tell user defaults
				if default entry "mysqlmysqlpwchanged" exists then
					set contents of default entry "mysqlmysqlpwchanged" to mysqlchanged
				else
					make new default entry at end of default entries with properties {name:"mysqlmysqlpwchanged", contents:mysqlchanged}
				end if
			end tell
		else
			display dialog "Please enter the existing password for the mysql mysql account." default answer "" buttons {"Cancel", "OK"} default button 2 with icon 1
			set oldpw to the text returned of the result
			display dialog "Please enter the new password for the mysql mysql account. You will need it frequently." default answer "" buttons {"Cancel", "OK"} default button 2 with icon 1
			set newpw to the text returned of the result
			--set button_pressed to the button returned of the result
			display dialog "You are going to set your new password for the MySQL mysql account to: " & newpw & ". Is this correct?" with icon 1
			if button returned of the result is "OK" then
				display dialog "The password for the MySQL mysql account is now " & newpw & ". Please keep this in a safe place." buttons {"OK"} default button 1 with icon 1
			end if
			set mysqlchanged to 1
			tell user defaults
				if default entry "mysqlmysqlpwchanged" exists then
					set contents of default entry "mysqlmysqlpwchanged" to mysqlchanged
				else
					make new default entry at end of default entries with properties {name:"mysqlmysqlpwchanged", contents:mysqlchanged}
				end if
			end tell
			
		end if
		
		
	end if
	if the name of theObject is "anonbtn" then
		tell user defaults
			if default entry "mysqlanonpwchanged" exists then
				set anonpwchanged to contents of default entry "mysqlanonpwchanged"
			else
				set anonpwchanged to 0
			end if
		end tell
		if anonpwchanged is 0 then
			display dialog "Please enter the new password for the anonymous MySQL account. You will need it frequently." default answer "" buttons {"Cancel", "OK"} default button 2 with icon 1
			set newpw to the text returned of the result
			--set button_pressed to the button returned of the result
			display dialog "You are going to set your new password for the anonymous MySQL account to: " & newpw & ". Is this correct?" with icon 1
			if button returned of the result is "OK" then
				
				display dialog "The password for the anonymous MySQL account is now " & newpw & ". Please keep this in a safe place." buttons {"OK"} default button 1 with icon 1
			end if
			set anonchanged to 1
			tell user defaults
				if default entry "mysqlanonpwchanged" exists then
					set contents of default entry "mysqlanonpwchanged" to anonchanged
				else
					make new default entry at end of default entries with properties {name:"mysqlanonpwchanged", contents:anonchanged}
				end if
			end tell
		else
			display dialog "Please enter the existing password for the anonymous MySQL account." default answer "" buttons {"Cancel", "OK"} default button 2 with icon 1
			set oldpw to the text returned of the result
			display dialog "Please enter the new password for the anonymous MySQLaccount. You will need it frequently." default answer "" buttons {"Cancel", "OK"} default button 2 with icon 1
			set newpw to the text returned of the result
			--set button_pressed to the button returned of the result
			display dialog "You are going to set your new password for the anonymous MySQL account to: " & newpw & ". Is this correct?" with icon 1
			if button returned of the result is "OK" then
				display dialog "The password for the anonymous MySQL account is now " & newpw & ". Please keep this in a safe place." buttons {"OK"} default button 1 with icon 1
			end if
			set anonchanged to 1
			tell user defaults
				if default entry "mysqlanonpwchanged" exists then
					set contents of default entry "mysqlanonpwchanged" to anonchanged
				else
					make new default entry at end of default entries with properties {name:"mysqlanonpwchanged", contents:anonchanged}
				end if
			end tell
			
		end if
	end if
	if the name of theObject is "changebtn" then
	end if
end clicked

on checkMysqlRunning(mysqlrunning)
	set mysqlrunning to 0
	do shell script "ps -A -C"
	set _Result to the result
	if _Result contains "/Applications/servebox/services/mysql/bin/mysqld_safe" then
		set mysqlrunning to 1
	else
		set mysqlrunning to 0
	end if
	if mysqlrunning is 0 then
		display dialog "MySQL isn't started. Please start it and try again" buttons {"OK"} default button 1 with icon 1
		set visible of window "mysqlpw" to false
	end if
	
	--display dialog mysqlrunning
end checkMysqlRunning
