-- apachemodules.applescript
-- ServeBox

--  Created by Alex Coomans on 6/14/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.
(*====
if visible of window "apachemodules" is false then
	set visible of window "apachemodules" to true
	tell window "apachemodules"
		activate
	end tell
end if====*)


--do shell script "httpd -t -D DUMP_MODULES"\
--do shell script "/Applications/servebox/services/Library/sbin/httpd -M"

--set _Result to the result
--set contents of text view "apachemodules" of scroll view "apachemodules" of window "apachemodules" to _Result as text

set apacherunning to 0
--if apacheinstalled is 1 then
do shell script "ps -A -C"
set _Result to the result
if _Result contains "/Applications/servebox/services/apache/sbin/httpd -k start" then
	set apacherunning to 1
else
	set apacherunning to 0
end if

if apacherunning is 1 then
	tell application "Terminal"
		do script "/Applications/servebox/services/apache/sbin/httpd -M"
	end tell
else
	display dialog "Apache isn't started. Please start it and try again" buttons {"OK"} default button 1 with icon 1
end if