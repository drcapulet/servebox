-- apahcelogs.applescript
-- ServeBox

--  Created by Alex Coomans on 6/18/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.


display dialog "Which Log do you want to open?" buttons {"Access", "Error Log"} default button 2 with icon 1
set the button_pressed to the button returned of the result
tell application "Console" to activate

if the button_pressed is "Access Log" then
	tell application "Console"
		--open (log "/Applications/MAMP/logs/apache_error.log")
		open (POSIX file "/Applications/servebox/services/apache/var/log/httpd/access.log")
	end tell
else if the button_pressed is "Error Log" then
	tell application "Console"
		--open (log "/Applications/MAMP/logs/apache_error.log")
		open (POSIX file "/Applications/servebox/services/apache/var/log/httpd/error.log")
	end tell
	
end if
