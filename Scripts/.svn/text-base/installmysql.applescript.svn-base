-- installmysql.applescript
-- ServeBox

--  Created by Alex Coomans on 7/5/08.
--  Copyright 2008 Alex Coomans. All rights reserved.


-- show window
if visible of window "downloadingmysql" is false then
	set visible of window "downloadingmysql" to true
	tell window "downloadingmysql"
		activate
	end tell
end if
-- set color of text
set color of text view "currenttask" of scroll view "currenttask" of window "downloadingmysql" to call method "whiteColor" of class "NSColor"
set color of text view "currentstep" of scroll view "currentstep" of window "downloadingmysql" to call method "whiteColor" of class "NSColor"
-- run download
start progress indicator "progress" of window "downloadingmysql"
-- Download PHPMyAdmin
set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Downloading MySQL"
set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 1 of 7"

set the contents of progress indicator "progress" of window "downloadingmysql" to 0

do shell script "cd /Applications/servebox/services/Library; curl -# -O http://www.alexcoomans.net/servebox/services/mysql/mysql.tar.gz >& /Applications/servebox/support_files/downloads/mysqlprog.txt &"
delay 1
set doc1 to POSIX file "/Applications/servebox/support_files/downloads/mysqlprog.txt"
set progtext to read file doc1
set progress to (get last word of progtext)
set the contents of progress indicator "progress" of window "downloadingmysql" to progress

--repeat
repeat until progress contains "100"
	set doc1 to POSIX file "/Applications/servebox/support_files/downloads/mysqlprog.txt"
	set progtext to read file doc1
	--set progress to (get last paragraph of progtext)
	set progress to (get last word of progtext)
	set the contents of progress indicator "progress" of window "downloadingmysql" to progress
end repeat
delay 1
--Install
set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Installing MySQL"
set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 2 of 7"

set the contents of progress indicator "progress" of window "downloadingmysql" to 0
do shell script "cd /Applications/servebox/services/Library; tar xvfz mysql.tar.gz"
set the contents of progress indicator "progress" of window "downloadingmysql" to 100

delay 1
-- Download config file
set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Setting up MySQL"
set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 3 of 7"

set the contents of progress indicator "progress" of window "downloadingmysql" to 0

do shell script "cd /Applications/servebox/services/Library/mysql; bin/mysql_install_db"
set the contents of progress indicator "progress" of window "downloadingmysql" to 100
delay 1
-- Install config file
set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Installing MySQL Configuration File"
set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 4 of 7"

set the contents of progress indicator "progress" of window "downloadingmysql" to 0
do shell script "chmod 644 /Applications/servebox/services/Library/mysql/etc/my.cnf"
set the contents of progress indicator "progress" of window "downloadingmysql" to 100

delay 1
-- getting php with mysql extentsion
set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Downloading PHP with MySQL"
set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 5 of 7"

set the contents of progress indicator "progress" of window "downloadingmysql" to 0
do shell script "cd /Applications/servebox/services/Library/modules; curl -# -O http://www.alexcoomans.net/servebox/services/php/php-withmysql.tar.gz >& /Applications/servebox/support_files/downloads/phpmysql.txt &"
delay 1
set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmysql.txt"
set progtext to read file doc1
set progress to (get last word of progtext)
set the contents of progress indicator "progress" of window "downloadingmysql" to progress

--repeat
repeat until progress contains "100"
	set doc1 to POSIX file "/Applications/servebox/support_files/downloads/phpmysql.txt"
	set progtext to read file doc1
	--set progress to (get last paragraph of progtext)
	set progress to (get last word of progtext)
	set the contents of progress indicator "progress" of window "downloadingmysql" to progress
end repeat

delay 1

-- install the module
set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Installing PHP with MySQL"
set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 6 of 7"

set the contents of progress indicator "progress" of window "downloadingmysql" to 0
do shell script "cd /Applications/servebox/services/Library/modules; mv libphp5.so libphp5-nosql.so; tar xvfz php-withmysql.tar.gz"
set the contents of progress indicator "progress" of window "downloadingmysql" to 100
delay 1
-- finish
set contents of text view "currenttask" of scroll view "currenttask" of window "downloadingwebsvn" to "Finishing"
set contents of text view "currentstep" of scroll view "currentstep" of window "downloadingwebsvn" to "Step 7 of 7"
set the contents of progress indicator "progress" of window "downloadingmysql" to 0
do shell script "cd /Applications/servebox/services/Library; rm mysql.tar.gz"
set the contents of progress indicator "progress" of window "downloadingmysql" to 35
do shell script "cd /Applications/servebox/services/Library/modules; rm php-withmysql.tar.gz"
set the contents of progress indicator "progress" of window "downloadingmysql" to 70
do shell script "mkdir /Applications/servebox/services/dbdata"
set the contents of progress indicator "progress" of window "downloadingmysql" to 100
delay 1

-- End
stop progress indicator "progress" of window "downloadingmysql"
-- Set to installed
set websvninstalled to "true"
tell user defaults to make new default entry at end of default entries with properties {name:"websvninstalled", contents:websvninstalled}
-- Set hidden to true on ok button
set enabled of button "okbutton" of window "downloadingwebsvn" to true