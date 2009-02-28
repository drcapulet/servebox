-- maintabs-mysql.applescript
-- ServeBox

--  Created by Alex Coomans on 6/29/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.


set mysqlinstalled to 0
--try
tell application "Finder"
	if (exists "/Applications/servebox/services/mysql" as POSIX file) then
		set mysqlinstalled to 1
	else
		set mysqlinstalled to 0
	end if
end tell
--end try
if mysqlinstalled is 0 then
	set visible of scroll view "notinstalled" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to true
	display dialog "We did not detect that MySQL is installed. You can install it by downloading the servebox installer and installing it." buttons {"OK"} default button 1 with icon 1
	(*display dialog "We did not detect that MySQL is installed. Would you like to install it?" buttons {"Cancel", "Install"} default button 2 with icon 1
	set the button_pressed to the button returned of the result
	if the button_pressed is "Install" then
		my runDownloadMysql()
		--run script (((path to me) as string) & "Contents:Resources:Scripts:installmysql.scpt") as alias
	end if*)
end if


-- Checking to see if mysql is running
set mysqlrunning to 0
if mysqlinstalled is 1 then
	do shell script "ps -A -C"
	set _Result to the result
	if _Result contains "/Applications/servebox/services/mysql/bin/mysqld" then
		set mysqlrunning to 1
	else
		set mysqlrunning to 0
	end if
end if



-- MySQL Stop/Start Button
if mysqlrunning is 1 then
	set title of button "mysqlstart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to "Stop MySQL"
else
	if mysqlrunning is 0 then
		set title of button "mysqlstart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to "Start MySQL"
	else
		if mysqlinstalled is 3 then
			set title of button "mysqlstart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to "Error"
		end if
	end if
end if

-- Restart Button

if mysqlrunning is 1 then
	tell button "mysqlrestart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to set enabled to true
else
	if mysqlrunning is 0 then
		tell button "mysqlrestart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to set enabled to false
	end if
end if



-- Starting/Stopping MySQL on Click
on clicked theObject
	if the name of theObject is "mysqlstart" then
		
		-- Checking to see if apache is running
		set mysqlrunning to 0
		do shell script "ps -A -C"
		set _Result to the result
		if _Result contains "/Applications/servebox/services/mysql/bin/mysqld" then
			set mysqlrunning to 1
		else
			set mysqlrunning to 0
		end if
		
		if mysqlrunning is 1 then
			tell user defaults
				if default entry "mysqlrootpwchanged" exists then
					set rootpwchanged to contents of default entry "mysqlrootpwchanged"
				else
					set rootpwchanged to 0
				end if
			end tell
			if rootpwchanged is 1 then
				start progress indicator "spinner" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
				--display dialog "Please enter the password for the root mysql account." default answer "" buttons {"Cancel", "OK"} default button 2 with icon 1
				--set pw to the text returned of the result
				--do shell script "cd /Applications/servebox/services/mysql; bin/mysqladmin -u root --password=" & pw & " shutdown" -- Stop Script
				tell application "Terminal"
					do script "cd /Applications/servebox/services/mysql; bin/mysqladmin -u root -p shutdown"
				end tell
				display dialog "Please enter the password for the root mysql account in the Terminal window, and then press Continue" buttons {"Continue"} default button 1 with icon 1
				stop progress indicator "spinner" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
				my mysqlButtons()
				--set title of button "mysqlstart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to "Start MySQL"
			else
				if rootpwchanged is 0 then
					start progress indicator "spinner" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
					do shell script "cd /Applications/servebox/services/mysql; bin/mysqladmin -u root shutdown" -- Stop Script
					stop progress indicator "spinner" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
					my mysqlButtons()
					--set title of button "mysqlstart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to "Start MySQL"
				end if
			end if
			
			
		else
			if mysqlrunning is 0 then
				tell user defaults
					if default entry "mysqlmysqlpwchanged" exists then
						set mysqlpwchanged to contents of default entry "mysqlmysqlpwchanged"
					else
						set mysqlpwchanged to 0
					end if
				end tell
				if mysqlpwchanged is 1 then
					start progress indicator "spinner" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
					--display dialog "Please enter the password for the default mysql account."  buttons {"Cancel", "OK"} default button 2 with icon 1
					--set pw to the text returned of the result
					tell application "Terminal"
						do script "/Applications/servebox/services/mysql/bin/mysqld_safe --user=mysql --log --log-error=/Applications/servebox/services/logs/mysql_error.log"
						delay 1
						quit saving no
					end tell
					--display dialog "Please enter the password for the mysql mysql account in the Terminal window, and then press Continue" buttons {"Continue"} default button 1 with icon 1
					stop progress indicator "spinner" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
					my mysqlButtons()
					
				else
					if mysqlpwchanged is 0 then
						start progress indicator "spinner" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
						tell application "Terminal"
							do script "/Applications/servebox/services/mysql/bin/mysqld_safe --user=mysql --log --log-error=/Applications/servebox/services/logs/mysql_error.log"
							delay 1
							quit saving no
						end tell
						stop progress indicator "spinner" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
						my mysqlButtons()
						--set title of button "mysqlstart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to "Stop MySQL"
					end if
				end if
			else
				if mysqlinstalled is 3 then
					display dialog "Error. It seems that we had trouble finding wheter or not MySQL was installed. Please report this bug to the developer." with icon 0
				end if
			end if
		end if
		(*
		if mysqlrunning is 0 then
			tell button "mysqlrestart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
				set enabled to true
			end tell
		else
			if mysqlrunning is 1 then
				tell button "mysqlrestart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
					set enabled to false
				end tell
			end if
		end if*)
		
	end if
	if the name of theObject is "mysqlrestart" then
		start progress indicator "restartspinner" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
		tell user defaults
			if default entry "mysqlrootpwchanged" exists then
				set rootpwchanged to contents of default entry "mysqlrootpwchanged"
			else
				set rootpwchanged to 0
			end if
		end tell
		if rootpwchanged is 1 then
			tell application "Terminal"
				do script "cd /Applications/servebox/services/mysql; ./bin/mysqladmin -u root -p  shutdown" -- Stop Script
			end tell
			display dialog "Please enter the password for the root mysql account in the Terminal window, and then press Continue" buttons {"Continue"} default button 1 with icon 1
		else
			do shell script "cd /Applications/servebox/services/mysql; ./bin/mysqladmin -u root shutdown" -- Stop Script
		end if
		--set mysqlstart to (resource path of main bundle) & "/mysqlstart.sh"
		--do shell script mysqlstart with administrator privileges
		tell application "Terminal"
			do script "/Applications/servebox/services/mysql/bin/mysqld_safe --user=mysql --log --log-error=/Applications/servebox/services/logs/mysql_error.log"
			quit saving no
		end tell
		
		--do shell script "/Applications/MAMP/Library/bin/httpd -k restart"
		stop progress indicator "restartspinner" of tab view item "mysqltab" of tab view "maintabs" of window "servebox"
	end if
	if the name of theObject is "phpmyadmin" then
		
		tell application "Finder"
			if (exists "/Applications/servebox/htdocs/phpmyadmin" as POSIX file) then
				my phpAdminCheck()
				
			else
				my runDownloadAdmin()
				
			end if
		end tell
		(*		tell user defaults
			if default entry "phpmyadmininstalled" exists then
				tell application "loginwindow" to open location "http://127.0.0.1:81/phpmyadmin/"
				
				display dialog "The default username for phpmyadmin is: root, and there is no default password" with icon 1
			else
				my runDownloadAdmin()
			end if
		end tell*)
		--if myadmininstalled is 1 then
		--	display dialog "The default username for phpmyadmin is: root, and there is no default password" with icon 1
		--end if
	end if
	
	if the name of theObject is "mysqllogs" then
		tell application "Console"
			--open (log "/Applications/MAMP/logs/apache_error.log")
			--open "/Applications/servebox/services/Library/var/log/httpd/acccess.log"
			
			open (POSIX file "/Applications/servebox/services/logs/mysql_error.log")
		end tell
	end if
	if the name of theObject is "passwordsbtn" then
		--display dialog "This feature is still being worked on" with icon 1
		run script (((path to me) as string) & "Contents:Resources:Scripts:mysqlpw.scpt") as alias
	end if
	if the name of theObject is "okbutton" then
		
		if visible of window "downloadingadmin" is true then
			set visible of window "downloadingadmin" to false
		end if
	end if
	if the name of theObject is "okbuttonmy" then
		if visible of window "downloadingmysql" is true then
			set visible of window "downloadingmysql" to false
		end if
	end if
end clicked

on displayPWdialog()
	display dialog "The default username for phpmyadmin is: root, and there is no default password" with icon 1
end displayPWdialog

on runDownloadAdmin()
	display dialog "PHPMyAdmin is not installed. Would you like to install it or cancel?" buttons {"Cancel", "Install"} default button 2 with icon 1
	set the button_pressed to the button returned of the result
	if the button_pressed is "Install" then
		-- show window
		set downloadingadmin to window "downloadingadmin"
		display panel downloadingadmin attached to window "servebox"
		(*====
		if visible of window "downloadingadmin" is false then
			set visible of window "downloadingadmin" to true
			tell window "downloadingadmin"
				activate
			end tell
		end if====*)
		-- set color of text
		--set color of text view "currenttask" of scroll view "currenttask" of window "downloadingadmin" to call method "whiteColor" of class "NSColor"
		--set color of text view "currentstep" of scroll view "currentstep" of window "downloadingadmin" to call method "whiteColor" of class "NSColor"
		-- run download
		start progress indicator "progress" of window "downloadingadmin"
		-- Download PHPMyAdmin
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingadmin" to "Downloading PHPMyAdmin"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingadmin" to "Step 1 of 6"
		
		set the contents of progress indicator "progress" of window "downloadingadmin" to 0
		display dialog "If you have Little Snitch Installed, please enable all connections from servebox and the curl system process" buttons {"OK"} default button 1 with icon 1
		set doc1 to (open for access file "Applications:servebox:support_files:downloads:phpmyadminprog.txt" with write permission)
		set eof of doc1 to 0
		close access doc1
		--set the contents of progress indicator "progress" of window "downloadingadmin" to 0
		do shell script "cd /Applications/servebox/htdocs; curl -# -O http://voxel.dl.sourceforge.net/sourceforge/phpmyadmin/phpMyAdmin-2.11.8.1-all-languages.tar.gz >& /Applications/servebox/support_files/downloads/phpmyadminprog.txt &"
		--delay 0.5
		--run script (((path to me) as string) & "Contents:Resources:Scripts:lsbypass.scpt") as alias
		
		delay 1
		
		try
			set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmyadminprog.txt"
			set progtext to read file doc1
			set progress to (get last word of progtext)
			set the contents of progress indicator "progress" of window "downloadingadmin" to progress
			
			--repeat
			repeat until progress contains "100"
				delay 0.5
				set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmyadminprog.txt"
				set progtext to read file doc1
				--set progress to (get last paragraph of progtext)
				set progress to (get last word of progtext)
				--set the contents of progress indicator "progress" of panel "downloadingadmin" to progress
				set the contents of progress indicator "progress" of panel "downloadingadmin" to progress
			end repeat
		on error
			set indeterminate of progress indicator "progress" of window "downloadingadmin" to true
			start progress indicator "progress" of window "downloadingadmin"
			
			delay 5
			try
				set indeterminate of progress indicator "progress" of window "downloadingadmin" to false
				set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmyadminprog.txt"
				set progtext to read file doc1
				set progress to (get last word of progtext)
				set the contents of progress indicator "progress" of window "downloadingadmin" to progress
				
				--repeat
				repeat until progress contains "100"
					delay 0.5
					set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmyadminprog.txt"
					set progtext to read file doc1
					set progress to (get last word of progtext)
					set the contents of progress indicator "progress" of window "downloadingadmin" to progress
					(*--delay 1
					set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmyadminprog.txt"
					set progtext to read file doc1
					--set progress to (get last paragraph of progtext)
					set progress to (get last word of progtext)
					--set the contents of progress indicator "progress" of panel "downloadingadmin" to progress
					set the contents of progress indicator "progress" of panel "downloadingadmin" to progress*)
				end repeat
				
			on error
				delay 20
				set indeterminate of progress indicator "progress" of window "downloadingadmin" to false
				set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmyadminprog.txt"
				set progtext to read file doc1
				set progress to (get last word of progtext)
				set the contents of progress indicator "progress" of window "downloadingadmin" to progress
				
				--repeat
				repeat until progress contains "100"
					delay 0.5
					set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmyadminprog.txt"
					set progtext to read file doc1
					--set progress to (get last paragraph of progtext)
					set progress to (get last word of progtext)
					set the contents of progress indicator "progress" of window "downloadingadmin" to progress
				end repeat
			end try
		end try
		delay 1
		--Install
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingadmin" to "Installing PHPMyAdmin"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingadmin" to "Step 2 of 6"
		
		set the contents of progress indicator "progress" of window "downloadingadmin" to 0
		
		do shell script "cd /Applications/servebox/htdocs; tar xvfz phpMyAdmin-2.11.8.1-all-languages.tar.gz; mv phpMyAdmin-2.11.8.1-all-languages phpmyadmin" with administrator privileges
		set the contents of progress indicator "progress" of window "downloadingadmin" to 100
		
		delay 1
		-- Download config file
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingadmin" to "Downloading Configuration File"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingadmin" to "Step 3 of 6"
		
		set the contents of progress indicator "progress" of window "downloadingadmin" to 0
		set doc1 to (open for access file "Applications:servebox:support_files:downloads:phpmyadminconfprog.txt" with write permission)
		set eof of doc1 to 0
		close access doc1
		do shell script "cd /Applications/servebox/htdocs/phpmyadmin; curl -# -O http://www.alexcoomans.net/servebox/services/phpmyadmin/myadminconfig.tar.gz >& /Applications/servebox/support_files/downloads/phpmyadminconfprog.txt" with administrator privileges
		delay 1
		(*====
		set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmyadminconfprog.txt"
		set progtext to read file doc1
		set progress to (get last word of progtext)
		set the contents of progress indicator "progress" of window "downloadingadmin" to progress
		
		--repeat
		repeat until progress contains "100"
			set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmyadminconfprog.txt"
			set progtext to read file doc1
			--set progress to (get last paragraph of progtext)
			set progress to (get last word of progtext)
			set the contents of progress indicator "progress" of window "downloadingadmin" to progress
		end repeat====*)
		
		delay 1
		-- Install config file
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingadmin" to "Installing Configuration File"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingadmin" to "Step 4 of 6"
		
		set the contents of progress indicator "progress" of window "downloadingadmin" to 0
		do shell script "cd /Applications/servebox/htdocs/phpmyadmin; tar xvfz myadminconfig.tar.gz" with administrator privileges
		set the contents of progress indicator "progress" of window "downloadingadmin" to 100
		
		delay 1
		
		-- set up mysql permissions
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingadmin" to "Setting up MySQL Permissions"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingadmin" to "Step 5 of 6"
		
		set the contents of progress indicator "progress" of window "downloadingadmin" to 0
		tell application "Terminal"
			do script "cd /Applications/servebox/services/mysql; bin/mysql --user=root mysql;
GRANT USAGE ON mysql.* TO 'pma'@'localhost' IDENTIFIED BY 'pma4565pma';
GRANT SELECT (
    Host, User, Select_priv, Insert_priv, Update_priv, Delete_priv,
    Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv,
    File_priv, Grant_priv, References_priv, Index_priv, Alter_priv,
    Show_db_priv, Super_priv, Create_tmp_table_priv, Lock_tables_priv,
    Execute_priv, Repl_slave_priv, Repl_client_priv
    ) ON mysql.user TO 'pma'@'localhost';
GRANT SELECT ON mysql.db TO 'pma'@'localhost';
GRANT SELECT ON mysql.host TO 'pma'@'localhost';
GRANT SELECT (Host, Db, User, Table_name, Table_priv, Column_priv)
    ON mysql.tables_priv TO 'pma'@'localhost';
exit;
"
			delay 2
			quit saving no
		end tell
		set the contents of progress indicator "progress" of window "downloadingadmin" to 100
		
		-- finish
		set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingadmin" to "Finishing"
		set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingadmin" to "Step 6 of 6"
		set the contents of progress indicator "progress" of window "downloadingadmin" to 0
		do shell script "cd /Applications/servebox/htdocs/phpmyadmin; rm myadminconfig.tar.gz" with administrator privileges
		do shell script "cd /Applications/servebox/htdocs; rm phpMyAdmin-2.11.8.1-all-languages.tar.gz" with administrator privileges
		
		set the contents of progress indicator "progress" of window "downloadingadmin" to 100
		delay 1
		-- End
		stop progress indicator "progress" of window "downloadingadmin"
		-- Set to installed
		--set phpmyadmininstalled to "true"
		--tell user defaults to make new default entry at end of default entries with properties {name:"phpmyadmininstalled", contents:phpmyadmininstalled}
		-- Set hidden to true on ok button
		set enabled of button "okbutton" of window "downloadingadmin" to true
	end if
end runDownloadAdmin

on runDownloadMysql()
	-- show window
	set downloadingmysql to window "downloadingmysql"
	display panel downloadingmysql attached to window "servebox"
	(*
	if visible of window "downloadingmysql" is false then
		set visible of window "downloadingmysql" to true
		tell window "downloadingmysql"
			activate
		end tell
	end if*)
	-- set color of text
	--set color of text view "currenttask" of scroll view "currenttask" of window "downloadingmysql" to call method "whiteColor" of class "NSColor"
	--set color of text view "currentstep" of scroll view "currentstep" of window "downloadingmysql" to call method "whiteColor" of class "NSColor"
	-- run download
	start progress indicator "progress" of window "downloadingmysql"
	-- Download PHPMyAdmin
	set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingmysql" to "Downloading MySQL"
	set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingmysql" to "Step 1 of 7"
	
	set the contents of progress indicator "progress" of window "downloadingmysql" to 0
	display dialog "If you have Little Snitch Installed, please enable all connections from servebox and the curl system process" buttons {"Ok"} default button 1 with icon 1
	set doc1 to (open for access file "Applications:servebox:support_files:downloads:mysqlprog.txt" with write permission)
	set eof of doc1 to 0
	close access doc1
	(*
	set theDownload to "Applications:servebox:services:mysql.tar.gz"
	set theLink to "http://www.alexcoomans.net/servebox/services/mysql/mysql.tar.gz"
	tell application "URL Access Scripting"
		download theLink to file theDownload
	end tell*)
	
	
	
	do shell script "cd /Applications/servebox/services; curl -# -O http://www.alexcoomans.net/servebox/services/mysql/mysql.tar.gz >& /Applications/servebox/support_files/downloads/mysqlprog.txt &"
	delay 1
	
	try
		set doc1 to POSIX file "/Applications/servebox/support_files/downloads/mysqlprog.txt"
		set progtext to read file doc1
		set progress to (get last word of progtext)
		set the contents of progress indicator "progress" of window "downloadingmysql" to progress
		
		--repeat
		repeat until progress contains "100"
			delay 0.5
			set doc1 to POSIX file "/Applications/servebox/support_files/downloads/mysqlprog.txt"
			set progtext to read file doc1
			--set progress to (get last paragraph of progtext)
			--set progress to (get last word of progtext)
			--set the contents of progress indicator "progress" of window "downloadingmysql" to progress
			set the contents of progress indicator "progress" of window "downloadingmysql" to the last word of progtext
		end repeat
		
	on error
		set indeterminate of progress indicator "progress" of window "downloadingmysql" to true
		start progress indicator "progress" of window "downloadingmysql"
		
		delay 5
		try
			set indeterminate of progress indicator "progress" of window "downloadingmysql" to false
			set doc1 to POSIX file "/Applications/servebox/support_files/downloads/mysqlprog.txt"
			set progtext to read file doc1
			set progress to (get last word of progtext)
			set the contents of progress indicator "progress" of window "downloadingmysql" to progress
			
			--repeat
			repeat until progress contains "100"
				delay 0.5
				set doc1 to POSIX file "/Applications/servebox/support_files/downloads/mysqlprog.txt"
				set progtext to read file doc1
				--set progress to (get last paragraph of progtext)
				--set progress to (get last word of progtext)
				--set the contents of progress indicator "progress" of window "downloadingmysql" to progress
				set the contents of progress indicator "progress" of window "downloadingmysql" to the last word of progtext
			end repeat
			
		on error
			delay 20
			set indeterminate of progress indicator "progress" of window "downloadingmysql" to false
			set doc1 to POSIX file "/Applications/servebox/support_files/downloads/mysqlprog.txt"
			set progtext to read file doc1
			set progress to (get last word of progtext)
			set the contents of progress indicator "progress" of window "downloadingmysql" to progress
			
			--repeat
			repeat until progress contains "100"
				delay 0.5
				set doc1 to POSIX file "/Applications/servebox/support_files/downloads/mysqlprog.txt"
				set progtext to read file doc1
				--set progress to (get last paragraph of progtext)
				set progress to (get last word of progtext)
				set the contents of progress indicator "progress" of window "downloadingmysql" to progress
			end repeat
			
		end try
	end try
	
	delay 1
	--Install
	set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingmysql" to "Installing MySQL"
	set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingmysql" to "Step 2 of 7"
	
	set the contents of progress indicator "progress" of window "downloadingmysql" to 0
	do shell script "cd /Applications/servebox/services/Library; tar xvfz mysql.tar.gz"
	set the contents of progress indicator "progress" of window "downloadingmysql" to 100
	
	delay 1
	-- Download config file
	set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingmysql" to "Setting up MySQL"
	set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingmysql" to "Step 3 of 7"
	
	set the contents of progress indicator "progress" of window "downloadingmysql" to 0
	do shell script "mkdir Applications/servebox/services/dbdata"
	do shell script "cd /Applications/servebox/services/mysql; bin/mysql_install_db"
	set the contents of progress indicator "progress" of window "downloadingmysql" to 100
	delay 1
	-- Install config file
	set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingmysql" to "Installing MySQL Configuration File"
	set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingmysql" to "Step 4 of 7"
	
	set the contents of progress indicator "progress" of window "downloadingmysql" to 0
	do shell script "chmod 644 /Applications/servebox/services/mysql/etc/my.cnf"
	set the contents of progress indicator "progress" of window "downloadingmysql" to 100
	
	delay 1
	-- getting php with mysql extentsion
	set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingmysql" to "Downloading PHP with MySQL"
	set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingmysql" to "Step 5 of 7"
	
	set the contents of progress indicator "progress" of window "downloadingmysql" to 0
	set doc1 to (open for access file "Applications:servebox:support_files:downloads:phpmysql.txt" with write permission)
	set eof of doc1 to 0
	close access doc1
	do shell script "cd /Applications/servebox/services/Library/modules; curl -# -O http://www.alexcoomans.net/servebox/services/php/php-withmysql.tar.gz >& /Applications/servebox/support_files/downloads/phpmysql.txt &"
	delay 1
	
	try
		set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmysql.txt"
		set progtext to read file doc1
		set progress to (get last word of progtext)
		set the contents of progress indicator "progress" of window "downloadingmysql" to progress
		
		--repeat
		repeat until progress contains "100"
			delay 0.5
			set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmysql.txt"
			set progtext to read file doc1
			--set progress to (get last paragraph of progtext)
			set progress to (get last word of progtext)
			set the contents of progress indicator "progress" of window "downloadingmysql" to progress
		end repeat
		
	on error
		set indeterminate of progress indicator "progress" of window "downloadingmysql" to true
		start progress indicator "progress" of window "downloadingmysql"
		
		delay 5
		try
			set indeterminate of progress indicator "progress" of window "downloadingmysql" to false
			set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmysql.txt"
			set progtext to read file doc1
			set progress to (get last word of progtext)
			set the contents of progress indicator "progress" of window "downloadingmysql" to progress
			
			--repeat
			repeat until progress contains "100"
				delay 0.5
				set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmysql.txt"
				set progtext to read file doc1
				--set progress to (get last paragraph of progtext)
				set progress to (get last word of progtext)
				set the contents of progress indicator "progress" of window "downloadingmysql" to progress
			end repeat
		on error
			delay 20
			set indeterminate of progress indicator "progress" of window "downloadingmysql" to false
			set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmysql.txt"
			set progtext to read file doc1
			set progress to (get last word of progtext)
			set the contents of progress indicator "progress" of window "downloadingmysql" to progress
			
			--repeat
			repeat until progress contains "100"
				delay 0.5
				set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmysql.txt"
				set progtext to read file doc1
				--set progress to (get last paragraph of progtext)
				set progress to (get last word of progtext)
				set the contents of progress indicator "progress" of window "downloadingmysql" to progress
			end repeat
		end try
	end try
	delay 1
	
	-- install the module
	set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingmysql" to "Installing PHP with MySQL"
	set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingmysql" to "Step 6 of 7"
	
	set the contents of progress indicator "progress" of window "downloadingmysql" to 0
	do shell script "cd /Applications/servebox/services/Library/modules; mv libphp5.so libphp5-nosql.so; tar xvfz php-withmysql.tar.gz"
	set the contents of progress indicator "progress" of window "downloadingmysql" to 100
	delay 1 -- finish
	set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingmysql" to "Finishing"
	set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingmysql" to "Step 7 of 7"
	set the contents of progress indicator "progress" of window "downloadingmysql" to 0
	do shell script "cd /Applications/servebox/services/Library; rm mysql.tar.gz"
	set the contents of progress indicator "progress" of window "downloadingmysql" to 50
	do shell script "cd /Applications/servebox/services/Library/modules; rm php-withmysql.tar.gz"
	--set the contents of progress indicator "progress" of window "downloadingmysql" to 70
	--do shell script "mkdir /Applications/servebox/services/dbdata"
	set the contents of progress indicator "progress" of window "downloadingmysql" to 100
	delay 1
	
	-- End
	stop progress indicator "progress" of window "downloadingmysql"
	-- Set to installed
	set mysqlinstalled to "true"
	tell user defaults to make new default entry at end of default entries with properties {name:"mysqlinstalled", contents:mysqlinstalled}
	-- Set hidden to true on ok button
	set enabled of button "okbuttonmy" of window "downloadingmysql" to true
end runDownloadMysql

on checkMysqlRunning(mysqlrunning)
	set mysqlrunning to 0
	do shell script "ps -A -C"
	set _Result to the result
	if _Result contains "/Applications/servebox/services/mysql/bin/mysqld" then
		set mysqlrunning to 1
	else
		set mysqlrunning to 0
	end if
	--display dialog mysqlrunning
end checkMysqlRunning

on mysqlButtons()
	
	set mysqlrunning to 0
	--if mysqlinstalled is 1 then
	do shell script "ps -A -C"
	set _Result to the result
	if _Result contains "/Applications/servebox/services/mysql/bin/mysqld" then
		set mysqlrunning to 1
	else
		set mysqlrunning to 0
	end if
	--end if
	-- MySQL Stop/Start Button
	if mysqlrunning is 1 then
		set title of button "mysqlstart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to "Stop MySQL"
	else
		if mysqlrunning is 0 then
			set title of button "mysqlstart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to "Start MySQL"
		else
			if mysqlinstalled is 3 then
				set title of button "mysqlstart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to "Error"
			end if
		end if
	end if
	
	-- Restart Button
	
	if mysqlrunning is 1 then
		tell button "mysqlrestart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to set enabled to true
	else
		if mysqlrunning is 0 then
			tell button "mysqlrestart" of tab view item "mysqltab" of tab view "maintabs" of window "servebox" to set enabled to false
		end if
	end if
	
end mysqlButtons

on checkApacheRunning(apacherunning)
	
	do shell script "ps -A -C"
	set _Result to the result
	if _Result contains "/Applications/servebox/services/apache/sbin/httpd -k start" then
		set apacherunning to 1
	else
		set apacherunning to 0
	end if
end checkApacheRunning

on phpAdminCheck()
	
	do shell script "ps -A -C"
	set _Result to the result
	if _Result contains "/Applications/servebox/services/apache/sbin/httpd -k start" then
		set apacherunning to 1
	else
		set apacherunning to 0
	end if
	if apacherunning is 1 then
		--mysql running check
		set mysqlrunning to 0
		do shell script "ps -A -C"
		set _Result to the result
		if _Result contains "/Applications/servebox/services/mysql/bin/mysqld" then
			set mysqlrunning to 1
		else
			set mysqlrunning to 0
		end if
		if mysqlrunning is 1 then
			tell application "loginwindow" to open location "http://127.0.0.1/phpmyadmin/"
			my displayPWdialog()
		else
			display dialog "MySQL isn't started. Please start it and try again" buttons {"OK"} default button 1 with icon 1
		end if
	else
		display dialog "Apache isn't started. Please start it and try again" buttons {"OK"} default button 1 with icon 1
	end if
	
end phpAdminCheck