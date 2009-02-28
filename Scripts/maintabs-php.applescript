-- maintabs-php.applescript
-- ServeBox

--  Created by Alex Coomans on 6/18/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.

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
if phpinstalled is 0 then
	set visible of scroll view "notinstalled" of tab view item "phptab" of tab view "maintabs" of window "servebox" to true
end if

(*====
my getPHPSetting()
display dialog "Setting is" & phpSetting
if phpSetting is "php4" then
	set current cell of matrix "phpselect" of tab view item "phptab" of tab view "maintabs" of window "servebox" to "php4"
else
	if phpSetting is "php5" then
		set current cell of matrix "phpselect" of tab view item "phptab" of tab view "maintabs" of window "servebox" to "php5"
	end if
end if  ====*)


on clicked theObject
	if the name of theObject is "phpapply" then
		if the name of the current cell of matrix "phpselect" of tab view item "phptab" of tab view "maintabs" of window "servebox" is "php4" then
			set phpRef to (open for access file "Users:alex:Desktop:filephp.conf" with write permission)
			set eof of phpRef to 0
			write "LoadModule php4_module        modules/libphp4.so" to phpRef
			close access phpRef
		else
			if the name of the current cell of matrix "phpselect" of tab view item "phptab" of tab view "maintabs" of window "servebox" is "php5" then
				set phpRef to (open for access file "Users:alex:Desktop:filephp.conf" with write permission)
				set eof of phpRef to 0
				write "LoadModule php5_module        modules/libphp5.so" to phpRef
				close access phpRef
			end if
		end if
		--set theWindow to "servebox"
		--my setPrefs(theWindow)
	end if
	if the name of theObject is "phpsettings" then
		run script (((path to me) as string) & "Contents:Resources:Scripts:phpsettings.scpt") as alias
	end if
	if the name of theObject is "phplogs" then
		--display dialog "Yeah. This isn't set up yet, Can't find the log file..." with icon 1
		tell application "Console"
			--open (log "/Applications/MAMP/logs/apache_error.log")
			open (POSIX file "/Applications/servebox/services/logs/php-error.log")
		end tell
		
		--tell application "Console"
		--open "/Applications/servebox/services/logs/php-error.log"
		--end tell
	end if
end clicked

(*==== User Defaults Save ====*)
-- For php4/php5 selection
(*==== 
on getPHPSetting()
	tell user defaults
		if contents of default entry "phpSetting" exists then
			set phpSetting to contents of default entry "phpSetting"
		end if
	end tell
end getPHPSetting


on setPrefs(theWindow)
	set phpSetting to the name of the current cell of matrix "phpselect" of tab view item "phptab" of tab view "maintabs" of window "servebox"
	tell user defaults
		if default entry "phpSetting" exists then
			set contents of default entry "phpSetting" to phpSetting
		else
			make new default entry at end of default entries with properties {name:"phpSetting", contents:phpSetting}
		end if
	end tell
end setPrefs
 ====*)