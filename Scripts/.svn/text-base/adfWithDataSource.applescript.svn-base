-- WithDataSource.applescript
-- ServeBox

--  Created by Alex Coomans on 6/15/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.
(* ==== Properties ==== *)

(* ====
property theDataSource : null
property presetMessages : {}
property selectedMessage : ""


(* ==== Subroutines ==== *)


on getMessageList()
	tell user defaults
		if contents of default entry "presetMessages" exists then
			set presetMessages to contents of default entry "presetMessages"
		end if
	end tell
end getMessageList


on setPrefs(theObject)
	set presetMessages to contents of data cells of data rows of data source of table view "messageList" of scroll view "messageList" of window of theObject
	tell user defaults
		if default entry "presetMessages" exists then
			set contents of default entry "presetMessages" to presetMessages
		else
			make new default entry at end of default entries with properties {name:"presetMessages", contents:presetMessages}
		end if
	end tell
end setPrefs

on clearMessageInfo(theWindow)
	tell theWindow
		set contents of text field "message" to ""
		set first responder to text field "message"
	end tell
end clearMessageInfo


-- Get the values from the text fields and set the cells in the the data row
--
on getMessageInfo(theWindow, theRow)
	tell theWindow
		set contents of data cell "message" of theRow to contents of text field "message"
	end tell
end getMessageInfo

-- Set the text fields with the values from the contact
--
on setMessageInfo(theWindow, theRow)
	tell theWindow
		set contents of text field "message" to contents of data cell "message" of theRow
	end tell
end setMessageInfo

(* ==== Event Handlers ==== *)


on will open theObject
	
	-- Create the data source
	set theDataSource to make new data source at end of data sources with properties {name:"messageList"}
	
	-- Create each of the data columns, including the sort information for each column
	make new data column at end of data columns of theDataSource with properties {name:"message"}
	--make new data column at end of data columns of theDataSource with properties {name:"message", sort order:ascending, sort type:alphabetical, sort case sensitivity:case sensitive
	
	set data source of table view "messageList" of scroll view "messageList" of theObject to theDataSource
	
	my getMessageList()
	-- Add the table data (using the new "append" command)
	append theDataSource with presetMessages
	
end will open


on clicked theObject
	if name of theObject is equal to "add" then
		-- Add a new contact
		set theRow to make new data row at the end of the data rows of theDataSource
		getMessageInfo(window of theObject, theRow)
		
		-- Clear out the contact information
		clearMessageInfo(window of theObject)
	else if name of theObject is "update" then
		set tableView to table view "messageList" of scroll view "messageList" of window of theObject
		set selectedDataRows to selected data rows of tableView
		if (count of selectedDataRows) > 0 then
			-- Update the contact
			getMessageInfo(window of theObject, item 1 of selectedDataRows)
			
			-- Tell the table view to update it's values
			tell tableView to update
		end if
	else if name of theObject is "remove" then
		set tableView to table view "messageList" of scroll view "messageList" of window of theObject
		set selectedDataRows to selected data rows of tableView
		if (count of selectedDataRows) > 0 then
			tell window of theObject
				-- Remove the contact form the data source
				delete (item 1 of selectedDataRows)
				
				-- Clear out the contact information
				my clearMessageInfo(window of theObject)
			end tell
		end if
	else if name of theObject is "presetMessages" then
		set visible of window named "messageWindow" to true
	else if name of theObject is "OK" then
		my setPrefs(theObject)
		set newMessage to contents of text field "message" of window of theObject
		set visible of window of theObject to false
		set contents of text view "emailComments" of scroll view "emailComments" of window 1 to newMessage
	end if
end clicked


on double clicked theObject
	my setPrefs(theObject)
	set newMessage to contents of text field "message" of window of theObject
	set visible of window of theObject to false
	set contents of text view "emailComments" of scroll view "emailComments" of window 1 to newMessage
end double clicked


on selection changed theObject
	if name of theObject is "messageList" then
		set theWindow to window of theObject
		
		-- Set the contact index to the current row, so that we can use it to update the right contact later
		set selectedDataRows to selected data rows of theObject
		
		if (count of selectedDataRows) = 0 then
			-- There wasn't any selected so clear the contact information
			my clearMessageInfo(theWindow)
			
			-- Disable the "Update" and "Remove" buttons
			set enabled of button "update" of theWindow to false
			set enabled of button "remove" of theWindow to false
		else
			-- A contact was selected, so show the contact information
			my setMessageInfo(theWindow, item 1 of selectedDataRows)
			
			-- Enable the "Update" and "Remove" buttons
			set enabled of button "update" of theWindow to true
			set enabled of button "remove" of theWindow to true
		end if
	end if
end selection changed ====*)