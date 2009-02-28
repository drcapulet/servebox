-- versions.applescript
-- ServerApp

--  Created by Alex Coomans on 6/10/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.

if visible of window "versions" is false then
	set visible of window "versions" to true
	tell window "versions"
		activate
	end tell
end if

start progress indicator "spinner" of window "versions"

-- Checking if installed

set apacheinstalled to 0
try
	do shell script "/Applications/servebox/services/apache/sbin/httpd -v"
	set _Result to the result
	if _Result contains "Server Version: Apache" then
		set apacheinstalled to 1
	end if
on error e number n
	if e contains "command not found" then
		set apacheinstalled to 0
	else
		display dialog "Error. It seems that we had trouble finding wheter or not Apache was installed. Please report this bug to the developer." with icon 0
		set apacheinstalled to 3
	end if
end try

set phpinstalled to 0
try
	do shell script "/Applications/servebox/services/php5/bin/php.dSYM -h"
	set _Result to the result
	if _Result contains "Usage:" then
		set phpinstalled to 1
	end if
on error e number n
	if e contains "command not found" then
		set phpinstalled to 0
	else
		display dialog "Error. It seems that we had trouble finding wheter or not PHP/Apache was installed. Please report this bug to the developer." with icon 0
		set phpinstalled to 3
	end if
end try


set mysqlinstalled to 0
--try
tell application "Finder"
	if (exists "/Applications/servebox/services/mysql" as POSIX file) then
		set mysqlinstalled to 1
	else
		set mysqlinstalled to 0
	end if
end tell
(*
	do shell script "/Applications/servebox/services/Library/mysql/bin/mysqladmin version"
	set _Result to the result
	if _Result contains "Uptime:" then
		set mysqlinstalled to 1
	end if
on error e number n
	if e contains "command not found" then
		set mysqlinstalled to 0
	else
		--display dialog "Error. It seems that we had trouble finding wheter or not MySQL was installed. Please report this bug to the developer." with icon 0
		set mysqlinstalled to 1
	end if *)
--end try


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


-- Window Settings

set font of text view "apachecheck" of scroll view "apachecheck" of window "versions" to call method "fontWithName:size:" of class "NSFont" with parameters {"Lucida Grande", 10}
if apacheinstalled is 1 then
	set contents of text view "apachecheck" of scroll view "apachecheck" of window "versions" to "Installed"
else
	if apacheinstalled is 0 then
		set contents of text view "apachecheck" of scroll view "apachecheck" of window "versions" to "Not Installed"
	else
		if apacheinstalled is 3 then
			set contents of text view "apachecheck" of scroll view "apachecheck" of window "versions" to "Error"
		end if
	end if
end if

set font of text view "phpcheck" of scroll view "phpcheck" of window "versions" to call method "fontWithName:size:" of class "NSFont" with parameters {"Lucida Grande", 10}
if phpinstalled is 1 then
	set contents of text view "phpcheck" of scroll view "phpcheck" of window "versions" to "Installed"
else
	if phpinstalled is 0 then
		set contents of text view "phpcheck" of scroll view "phpcheck" of window "versions" to "Not Installed"
	else
		if phpinstalled is 3 then
			set contents of text view "phpcheck" of scroll view "phpcheck" of window "versions" to "Error"
		end if
	end if
end if

set font of text view "mysqlcheck" of scroll view "mysqlcheck" of window "versions" to call method "fontWithName:size:" of class "NSFont" with parameters {"Lucida Grande", 10}
if mysqlinstalled is 1 then
	set contents of text view "mysqlcheck" of scroll view "mysqlcheck" of window "versions" to "Installed"
else
	if mysqlinstalled is 0 then
		set contents of text view "mysqlcheck" of scroll view "mysqlcheck" of window "versions" to "Not Installed"
	else
		if mysqlinstalled is 3 then
			set contents of text view "mysqlcheck" of scroll view "mysqlcheck" of window "versions" to "Error"
		end if
	end if
end if

set font of text view "svncheck" of scroll view "svncheck" of window "versions" to call method "fontWithName:size:" of class "NSFont" with parameters {"Lucida Grande", 10}
if svninstalled is 1 then
	set contents of text view "svncheck" of scroll view "svncheck" of window "versions" to "Installed"
else
	if svninstalled is 0 then
		set contents of text view "svncheck" of scroll view "svncheck" of window "versions" to "Not Installed"
	else
		if svninstalled is 3 then
			set contents of text view "svncheck" of scroll view "svncheck" of window "versions" to "Error"
		end if
	end if
end if



stop progress indicator "spinner" of window "versions"
