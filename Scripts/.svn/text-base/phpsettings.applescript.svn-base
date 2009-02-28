-- phpsettings.applescript
-- ServeBox

--  Created by Alex Coomans on 6/19/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.

-- Make Window Visible
if visible of window "phpsettingshud" is false then
	set visible of window "phpsettingshud" to true
	tell window "phpsettingshud"
		activate
	end tell
end if

(* ==== Properties ==== *)


property phpmemlimit : {}
property uploadmaxfilesize : {}
property uploadtmpdir : {}
property shorttags : {}

-- Get user prefs
my getPHPSettings()
set contents of text field "phpmemlimit" of window "phpsettingshud" to phpmemlimit
set contents of text field "uploadmaxfilesize" of window "phpsettingshud" to uploadmaxfilesize
set contents of text field "uploadtmpdir" of window "phpsettingshud" to uploadtmpdir
set state of button "shorttags" of window "phpsettingshud" to shorttags


on clicked theObject
	if the name of theObject is "choose" then
		set docroot to (POSIX file "/") as alias
		set theFolderDocumentRoot to choose folder with prompt "Please choose the upload_tmp_directory" default location docroot without invisibles
		set theFolder1DocumentRoot to POSIX path of theFolderDocumentRoot
		set contents of text field "uploadtmpdir" of window "phpsettingshud" to theFolder1DocumentRoot
	end if
	if the name of theObject is "applysettings" then
		start progress indicator "phpprogress" of window "phpsettingshud"
		--set contents of progress indicator "phpprogress" to 10
		my setPrefs()
		do shell script "cp -R /Applications/servebox/support_files/php5/php.ini  /Applications/servebox/services/php5/lib"
		--Write PHP Memory Limit
		set theFile to "Applications:servebox:services:php5:lib:php.ini"
		try
			set ff to open for access theFile with write permission
			set theText to (read ff)
			set phpmemlimit to the contents of text field "phpmemlimit" of window "phpsettingshud"
			set {ASTID, AppleScript's text item delimiters} to {AppleScript's text item delimiters, "<memlim>"}
			set theText to text items of theText
			set AppleScript's text item delimiters to phpmemlimit
			set theText to theText as string
			set AppleScript's text item delimiters to ASTID
			write theText to ff starting at 0
			close access ff
		on error
			try
				close access theFile
			end try
		end try
		-- Upload Max Filesize
		set theFile to "Applications:servebox:services:php5:lib:php.ini"
		try
			set ff to open for access theFile with write permission
			set theText to (read ff)
			set uploadmaxfilesize to the contents of text field "uploadmaxfilesize" of window "phpsettingshud"
			set {ASTID, AppleScript's text item delimiters} to {AppleScript's text item delimiters, "<02lim>"}
			set theText to text items of theText
			set AppleScript's text item delimiters to uploadmaxfilesize
			set theText to theText as string
			set AppleScript's text item delimiters to ASTID
			write theText to ff starting at 0
			close access ff
		on error
			try
				close access theFile
			end try
		end try
		--Upload Tmp Dir
		set theFile to "Applications:servebox:services:php5:lib:php.ini"
		try
			set ff to open for access theFile with write permission
			set theText to (read ff)
			set uploadtmpdir to the contents of text field "uploadtmpdir" of window "phpsettingshud"
			set {ASTID, AppleScript's text item delimiters} to {AppleScript's text item delimiters, "<tmpdir>"}
			set theText to text items of theText
			set AppleScript's text item delimiters to uploadtmpdir
			set theText to theText as string
			set AppleScript's text item delimiters to ASTID
			write theText to ff starting at 0
			close access ff
		on error
			try
				close access theFile
			end try
		end try
		-- Short Tags Enables/Disabled
		if state of button "shorttags" of window "phpsettingshud" is 1 then
			-- enabled code
			set theFile to "Applications:servebox:services:php5:lib:php.ini"
			try
				set ff to open for access theFile with write permission
				set theText to (read ff)
				set shorttags to "TRUE"
				set {ASTID, AppleScript's text item delimiters} to {AppleScript's text item delimiters, "<tag>"}
				set theText to text items of theText
				set AppleScript's text item delimiters to shorttags
				set theText to theText as string
				set AppleScript's text item delimiters to ASTID
				write theText to ff starting at 0
				close access ff
			on error
				try
					close access theFile
				end try
			end try
		else
			if state of button "shorttags" of window "phpsettingshud" is 0 then
				set theFile to "Applications:servebox:services:php5:lib:php.ini"
				try
					set ff to open for access theFile with write permission
					set theText to (read ff)
					set shorttags to "FALSE"
					set {ASTID, AppleScript's text item delimiters} to {AppleScript's text item delimiters, "<tag>"}
					set theText to text items of theText
					set AppleScript's text item delimiters to shorttags
					set theText to theText as string
					set AppleScript's text item delimiters to ASTID
					write theText to ff starting at 0
					close access ff
				on error
					try
						close access theFile
					end try
				end try
			end if
			
		end if
		--set contents of progress indicator "phpprogress" to 100
		stop progress indicator "phpprogress" of window "phpsettingshud"
	end if
	if the name of theObject is "close" then
		if visible of window "phpsettingshud" is true then
			set visible of window "phpsettingshud" to false
		end if
		display dialog "Apache must be restarted for these changes to take effect. Would you like to restart?" buttons {"No", "Restart"} default button 2 with icon 1
		try
			do shell script "/Applications/servebox/services/apache/sbin/httpd -k restart" with administrator privileges
		on error
			display dialog "Uh oh! servebox had an error restarting Apache" with icon 0
		end try
		
	end if
end clicked



(*===== Data ======*)

(* ==== Properties ==== *)

(*====
property phpmemlimit : {}
property uploadmaxfilesize : {}
property uploadtmpdir : {}
property shorttags : {}
=====*)



(* ==== Event Handlers ==== *)



-- Save data for save on relaunch
--

on getPHPSettings()
	tell user defaults
		-- Mem Limit
		if contents of default entry "phpmemlimit" exists then
			set phpmemlimit to contents of default entry "phpmemlimit"
		else
			set phpmemlimit to ""
		end if
		-- Upload Max Filesize
		if contents of default entry "uploadmaxfilesize" exists then
			set uploadmaxfilesize to contents of default entry "uploadmaxfilesize"
		else
			set uploadmaxfilesize to ""
		end if
		-- Upload Tmp Dir
		if contents of default entry "uploadtmpdir" exists then
			set uploadtmpdir to contents of default entry "uploadtmpdir"
		else
			set uploadtmpdir to ""
		end if
		-- Short Tags
		if contents of default entry "shorttags" exists then
			set shorttags to contents of default entry "shorttags"
		else
			set shorttags to 0
		end if
	end tell
end getPHPSettings


on setPrefs()
	set phpmemlimit to contents of text field "phpmemlimit" of window "phpsettingshud"
	set uploadmaxfilesize to contents of text field "uploadmaxfilesize" of window "phpsettingshud"
	set uploadtmpdir to contents of text field "uploadtmpdir" of window "phpsettingshud"
	set shorttags to state of button "shorttags" of window "phpsettingshud"
	tell user defaults
		-- Memory Limit
		if default entry "phpmemlimit" exists then
			set contents of default entry "phpmemlimit" to phpmemlimit
		else
			make new default entry at end of default entries with properties {name:"phpmemlimit", contents:phpmemlimit}
		end if
		-- Upload Max Filesize
		if default entry "uploadmaxfilesize" exists then
			set contents of default entry "uploadmaxfilesize" to uploadmaxfilesize
		else
			make new default entry at end of default entries with properties {name:"uploadmaxfilesize", contents:uploadmaxfilesize}
		end if
		-- Upload Tmp Dir
		if default entry "uploadtmpdir" exists then
			set contents of default entry "uploadtmpdir" to uploadtmpdir
		else
			make new default entry at end of default entries with properties {name:"uploadtmpdir", contents:uploadtmpdir}
		end if
		-- Short Tags Enabled/Disabled
		if default entry "shorttags" exists then
			set contents of default entry "shorttags" to shorttags
		else
			make new default entry at end of default entries with properties {name:"shorttags", contents:shorttags}
		end if
	end tell
end setPrefs
