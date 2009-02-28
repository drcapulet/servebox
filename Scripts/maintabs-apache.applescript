-- maintabs-apache.applescript
-- ServeBox

--  Created by Alex Coomans on 6/11/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.

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
if apacheinstalled is 0 then
	set visible of scroll view "notinstalled" of tab view item "apachetab" of tab view "maintabs" of window "servebox" to true
end if


(*====
-- Setting Installed/not installed tabs
if apacheinstalled is 1 then
	tell tab view "apacheinstalledtabs" of tab view "maintabs" of window "servebox"
		set current tab view item to tab view item "apachetab-installed"
	end tell
else
	if apacheinstalled is 0 then
		tell tab view "apacheinstalledtabs" of tab view "maintabs" of window "servebox"
			set current tab view item to tab view item "apachetab-notinstalled"
		end tell
		set contents of text view "apachenotinstalled-textview" of scroll view "apachenotinstalled-textview" of window "servebox" to "Apache Not Installed"
	else
		if apacheinstalled is 3 then
			tell tab view "apacheinstalledtabs" of tab view "maintabs" of window "servebox"
				set current tab view item to tab view item "apachetab-notinstalled"
			end tell
			set contents of text view "apachenotinstalled-textview" of scroll view "apachenotinstalled-textview" of window "servebox" to "Error"
		end if
	end if
end if ====*)

-- Checking to see if apache is running
--set apacheinstalled to 1
set apacherunning to 0
if apacheinstalled is 1 then
	do shell script "ps -A -C"
	set _Result to the result
	if _Result contains "/Applications/servebox/services/apache/sbin/httpd -k start" then
		set apacherunning to 1
	else
		set apacherunning to 0
	end if
end if



-- Apache Stop/Start Button
if apacherunning is 1 then
	set title of button "apachestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox" to "Stop Apache"
else
	if apacherunning is 0 then
		set title of button "apachestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox" to "Start Apache"
	else
		if apacheinstalled is 3 then
			set title of button "apachestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox" to "Error"
		end if
	end if
end if

-- Restart Button

if apacherunning is 1 then
	tell button "apacherestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
		set enabled to true
	end tell
else
	if apacherunning is 0 then
		tell button "apacherestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
			set enabled to false
		end tell
	end if
end if



-- Starting/Stopping Apache on Click
on clicked theObject
	if the name of theObject is "apachestart" then
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
		
		set apacherunning to 1
		-- Checking to see if apache is running
		set apacherunning to 0
		if apacheinstalled is 1 then
			do shell script "ps -A -C"
			set _Result to the result
			if _Result contains "/Applications/servebox/services/apache/sbin/httpd -k start" then
				set apacherunning to 1
			else
				set apacherunning to 0
			end if
		end if
		
		if apacherunning is 1 then
			start progress indicator "spinner" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
			try
				do shell script "/Applications/servebox/services/apache/sbin/httpd -k stop" with administrator privileges
			on error
				display dialog "Uh oh! servebox had an error stopping Apache" with icon 0
			end try
			delay 1
			my checkApacheStatus()
			stop progress indicator "spinner" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
			
		else
			if apacherunning is 0 then
				start progress indicator "spinner" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
				try
					do shell script "/Applications/servebox/services/apache/sbin/httpd -k start" with administrator privileges
				on error
					display dialog "Uh oh! servebox had an error starting Apache" with icon 0
				end try
				delay 1
				my checkApacheStatus()
				stop progress indicator "spinner" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
			else
				if apacheinstalled is 3 then
					display dialog "Error. It seems that we had trouble finding whether or not Apache was installed. Please report this bug to the developer." with icon 0
				end if
			end if
		end if
		(*
		if apacherunning is 0 then
			my checkApacheStatus()
			tell button "apacherestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
				set enabled to true
			end tell
		else
			if apacherunning is 1 then
				my checkApacheStatus()
				tell button "apacherestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
					set enabled to false
				end tell
			end if
		end if*)
		
	end if
	if the name of theObject is "apacherestart" then
		start progress indicator "restartspinner" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
		try
			do shell script "/Applications/servebox/services/apache/sbin/httpd -k restart" with administrator privileges
		on error
			display dialog "Uh oh! servebox had an error restarting Apache" with icon 0
		end try
		
		stop progress indicator "restartspinner" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
		my checkApacheStatus()
	end if
	if the name of theObject is "apachemodules" then
		run script (((path to me) as string) & "Contents:Resources:Scripts:apachemodules.scpt") as alias
	end if
	if the name of theObject is "virtualhostsbtn" then
		
		run script (((path to me) as string) & "Contents:Resources:Scripts:apache-managevirtualhosts.scpt") as alias
	end if
	if the name of theObject is "apachelogs" then
		run script (((path to me) as string) & "Contents:Resources:Scripts:apachelogs.scpt") as alias
	end if
end clicked

on checkApacheStatus()
	set aprunning to 0
	--if apacheinstalled is 1 then
	do shell script "ps -A -C"
	set _Result to the result
	if _Result contains "/Applications/servebox/services/apache/sbin/httpd" then
		set aprunning to 1
	else
		set aprunning to 0
	end if
	--end if
	--display dialog aprunning
	-- Apache Stop/Start Button
	if aprunning is 1 then
		set title of button "apachestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox" to "Stop Apache"
	else
		if aprunning is 0 then
			set title of button "apachestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox" to "Start Apache"
		else
			if apacheinstalled is 3 then
				set title of button "apachestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox" to "Error"
			end if
		end if
	end if
	-- restart
	if aprunning is 1 then
		tell button "apacherestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
			set enabled to true
		end tell
	else
		if aprunning is 0 then
			tell button "apacherestart" of tab view item "apachetab" of tab view "maintabs" of window "servebox"
				set enabled to false
			end tell
		end if
	end if
end checkApacheStatus

on apacheisrunning(apacherunning)
	set apacherunning to 0
	--if apacheinstalled is 1 then
	do shell script "ps -A -C"
	set _Result to the result
	if _Result contains "/Applications/servebox/services/apache/sbin/httpd -k start" then
		set apacherunning to 1
	else
		set apacherunning to 0
	end if
end apacheisrunning