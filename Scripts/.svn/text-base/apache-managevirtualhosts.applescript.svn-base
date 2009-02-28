-- apache-managevirtualhosts.applescript
-- ServeBox

--  Created by Alex Coomans on 6/12/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.

if visible of window "apachevirtualhosts" is false then
	set visible of window "apachevirtualhosts" to true
	tell window "apachevirtualhosts"
		activate
	end tell
end if

set apacherunning to 0
--if apacheinstalled is 1 then
do shell script "ps -A -C"
set _Result to the result
if _Result contains "/Applications/servebox/services/apache/sbin/httpd -k start" then
	set apacherunning to 1
else
	set apacherunning to 0
end if

if apacherunning is 0 then
	display dialog "Apache isn't started. Please start it and try again" buttons {"OK"} default button 1 with icon 1
	set visible of window "apachevirtualhosts" to false
end if



(*====
on clicked theObject
	if the name of theObject is equal to "virtualhosts-choosedestination" then
		set docroot to (POSIX file "/") as alias
		set theFolderDocumentRoot to choose folder with prompt "Please choose the volume (from Devices List) to install kext to. DO NOT select a folder." default location docroot without invisibles
		set theFolder1DocumentRoot to POSIX path of theFolderDocumentRoot
		set contents of text field "virtualhosts-dochosttextfield" of box "docroot" of tab view item "general" of tab view "hoststabs" of window "apachevirtualhosts" to theFolder1DocumentRoot
	end if

	if the name of theObject is equal to "virt-save" then
		set servername to the contents of text field "servername" of tab view item "general" of tab view "hoststabs" of window "apachevirtualhosts"
		set serverport to the contents of text field "serverport" of tab view item "general" of tab view "hoststabs" of window "apachevirtualhosts"
		
		set fileRef to (open for access file "Users:alex:Desktop:file.txt" with write permission)
		-- this will return a "reference number", which is similar to a stream,
		-- or just as the ticket you need to ride through the bytes
		
		-- the following will delete the contents of the file
		set eof of fileRef to 0
		write "<VirtualHost " to fileRef
		write servername to fileRef
		write ":" to fileRef
		write serverport to fileRef
		write ">" to fileRef
		write "</VirtualHost>" to fileRef
		close access fileRef
		--> this has closed the "way" we opened previously using the "open for access" command
	end if
end clicked ====*)









(*===== Data ======*)

(* ==== Properties ==== *)

property hostsDataSource : null
property virtualHosts : {}



(* ==== Event Handlers ==== *)

on clicked theObject
	(* ==== Seave data to user prefs on click of Apply ====*)
	if the name of theObject is equal to "apply" then
		my setPrefs(theObject)
		set fileRef to (open for access file "Applications:servebox:services:conf:apache:servebox-vhosts.conf" with write permission)
		set eof of fileRef to 0
		set break to "
"
		write "# Virtual Hosts Configuration" to fileRef
		write break to fileRef
		write "# Do Not Modify By Hand. Use servebox. These lines of code are re-written every save" to fileRef
		write break to fileRef
		write break to fileRef
		
		set rowCount to count data rows in hostsDataSource
		-- set numberrows to call method "numberOfRows" of hostsDataSource
		-- Save data to conf file
		repeat with I from 1 to rowCount
			set theRow to data row I in hostsDataSource
			set servername to contents of data cell "servername" of theRow
			set serverport to contents of data cell "serverport" of theRow
			if serverport is "" then
				set serverport to "80"
			end if
			set docroot to contents of data cell "docroot" of theRow
			set zip to contents of data cell "zip" of theRow
			set break to "
"
			-- open file for access			
			-- this will return a "reference number", which is similar to a stream,
			-- or just as the ticket you need to ride through the bytes
			
			-- the following will delete the contents of the file
			
			-- Apache NameVirtualHost
			write "NameVirtualHost " to fileRef
			write servername to fileRef
			write ":" to fileRef
			write serverport to fileRef
			write break to fileRef
			write break to fileRef
			
			-- Each Server Config
			
			-- Header
			write "<VirtualHost " to fileRef
			write servername to fileRef
			write ":" to fileRef
			write serverport to fileRef
			write ">" to fileRef
			write break to fileRef
			-- ServerName
			write "	ServerName " to fileRef
			write servername to fileRef
			write break to fileRef
			-- Doc Root
			write "	DocumentRoot " to fileRef
			write docroot to fileRef
			write break to fileRef
			--End
			write "</VirtualHost>" to fileRef
			write break to fileRef
			write break to fileRef
			
		end repeat
		close access fileRef
	end if
	(* ==== Choose Destination  =====*)
	if the name of theObject is equal to "virtualhosts-choosedestination" then
		set docroot to (POSIX file "/") as alias
		set theFolderDocumentRoot to choose folder with prompt "Please choose the document root for this virtual host" default location docroot without invisibles
		set theFolder1DocumentRoot to POSIX path of theFolderDocumentRoot
		set contents of text field "docroot" of window "apachevirtualhosts" to theFolder1DocumentRoot
	end if
	(*==== Data Source ====*)
	if name of theObject is equal to "add" then
		-- Add a new contact
		set theRow to make new data row at the end of the data rows of hostsDataSource
		getContactInfo(window of theObject, theRow)
		
		-- Clear out the contact information
		clearContactInfo(window of theObject)
	else if name of theObject is "update" then
		set tableView to table view "contacts" of scroll view "contacts" of window of theObject
		set selectedDataRows to selected data rows of tableView
		if (count of selectedDataRows) > 0 then
			-- Update the contact
			getContactInfo(window of theObject, item 1 of selectedDataRows)
			
			-- Tell the table view to update it's values
			tell tableView to update
		end if
	else if name of theObject is "remove" then
		set tableView to table view "contacts" of scroll view "contacts" of window of theObject
		set selectedDataRows to selected data rows of tableView
		if (count of selectedDataRows) > 0 then
			tell window of theObject
				-- Remove the contact form the data source
				delete (item 1 of selectedDataRows)
				
				-- Clear out the contact information
				my clearContactInfo(window of theObject)
			end tell
		end if
	end if
end clicked

on will open theObject
	-- Set up the contactDataSource so that the rest will be simpler
	set hostsDataSource to data source of table view "contacts" of scroll view "contacts" of theObject
	
	-- Here we will add the data columns to the data source of the contacts table view
	tell hostsDataSource
		make new data column at the end of the data columns with properties {name:"servername"}
		make new data column at the end of the data columns with properties {name:"serverport"}
		make new data column at the end of the data columns with properties {name:"docroot"}
		make new data column at the end of the data columns with properties {name:"state"}
		make new data column at the end of the data columns with properties {name:"zip"}
	end tell
	
	my getMessageList()
	-- Add the table data (using the new "append" command)
	append hostsDataSource with virtualHosts
end will open

on update toolbar item
	update toolbar item
	--update toolbar item "removetool" of toolbar of theWindow 
	--update toolbar item "updatetool" of toolbar of theWindow 
end update toolbar item

on selection changed theObject
	if name of theObject is "contacts" then
		set theWindow to window of theObject
		
		-- Set the contact index to the current row, so that we can use it to update the right contact later
		set selectedDataRows to selected data rows of theObject
		
		if (count of selectedDataRows) = 0 then
			-- There wasn't any selected so clear the contact information
			my clearContactInfo(theWindow)
			
			-- Disable the "Update" and "Remove" buttons
			set enabled of button "update" of theWindow to false
			set enabled of button "remove" of theWindow to false
			--set enabled of toolbar item "updatetool" of toolbar of theWindow to false
			--set enabled of toolbar item "removetool" of toolbar of theWindow to false
			--update toolbar item
			
		else
			-- A contact was selected, so show the contact information
			my setContactInfo(theWindow, item 1 of selectedDataRows)
			
			-- Enable the "Update" and "Remove" buttons
			set enabled of button "update" of theWindow to true
			set enabled of button "remove" of theWindow to true
		end if
	end if
end selection changed


(* ==== Contact Handlers ==== *)

-- Empty all of the text fields
--
on clearContactInfo(theWindow)
	tell theWindow
		set contents of text field "servername" to ""
		set contents of text field "serverport" to ""
		set contents of text field "docroot" to ""
		set contents of text field "state" to ""
		set contents of text field "zip" to ""
		set first responder to text field "servername"
	end tell
end clearContactInfo

-- Get the values from the text fields and set the cells in the the data row
--
on getContactInfo(theWindow, theRow)
	tell theWindow
		set contents of data cell "servername" of theRow to contents of text field "servername"
		set contents of data cell "serverport" of theRow to contents of text field "serverport"
		set contents of data cell "docroot" of theRow to contents of text field "docroot"
		set contents of data cell "state" of theRow to contents of text field "state"
		set contents of data cell "zip" of theRow to contents of text field "zip"
	end tell
end getContactInfo

-- Set the text fields with the values from the contact
-- 
on setContactInfo(theWindow, theRow)
	tell theWindow
		set contents of text field "servername" to contents of data cell "servername" of theRow
		set contents of text field "serverport" to contents of data cell "serverport" of theRow
		set contents of text field "docroot" to contents of data cell "docroot" of theRow
		set contents of text field "state" to contents of data cell "state" of theRow
		set contents of text field "zip" to contents of data cell "zip" of theRow
	end tell
end setContactInfo

-- Save data for save on relaunch
--

on getMessageList()
	tell user defaults
		if contents of default entry "virtualHosts" exists then
			set virtualHosts to contents of default entry "virtualHosts"
		end if
	end tell
end getMessageList


on setPrefs(theObject)
	set virtualHosts to contents of data cells of data rows of data source of table view "contacts" of scroll view "contacts" of window of theObject
	tell user defaults
		if default entry "virtualHosts" exists then
			set contents of default entry "virtualHosts" to virtualHosts
		else
			make new default entry at end of default entries with properties {name:"virtualHosts", contents:virtualHosts}
		end if
	end tell
end setPrefs
