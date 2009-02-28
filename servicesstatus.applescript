-- servicesstatus.applescript
-- ServeBox

--  Created by Alex Coomans on 7/27/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.
my refresh()
if visible of window "statushud" is false then
	set visible of window "statushud" to true
	tell window "statushud"
		activate
	end tell
end if

on clicked theObject
	if the name of theObject is "refresh" then
		my refresh()
	end if
	if the name of theObject is "refresh60" then
		repeat
			set state1 to the state of button "refresh60" of window "statushud"
			if state1 is 1 then
				delay 5
				my refresh()
			end if
		end repeat
	end if
end clicked

on refresh()
	do shell script "ps -A -C"
	set _Result to the result
	-- apache
	if _Result contains "/Applications/servebox/services/apache/sbin/httpd -k start" then
		set apacherunning to 1
	else
		set apacherunning to 0
	end if
	--mysql
	if _Result contains "/Applications/servebox/services/Library/mysql/bin/mysqld" then
		set mysqlrunning to 1
	else
		set mysqlrunning to 0
	end if
	--apache status set
	if apacherunning is 1 then
		set visible of image view "apacheminus" of window "statushud" to false
		set visible of image view "apacheplus" of window "statushud" to true
	else
		set visible of image view "apacheplus" of window "statushud" to false
		set visible of image view "apacheminus" of window "statushud" to true
	end if
	--mysql status set
	if mysqlrunning is 1 then
		set visible of image view "mysqlminus" of window "statushud" to false
		set visible of image view "mysqlplus" of window "statushud" to true
	else
		set visible of image view "mysqlplus" of window "statushud" to false
		set visible of image view "mysqlminus" of window "statushud" to true
	end if
end refresh