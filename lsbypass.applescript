-- lsbypass.applescript
-- ServeBox

--  Created by Alex Coomans on 7/19/08.
--  Copyright 2008 __MyCompanyName__. All rights reserved.
tell application "System Events"
	tell process "Little Snitch UIAgent"
		tell window "Little Snitch"
			-- The few lines below are not mandatory
			-- It allows to set  "Allow Any network connection" (default is "Allow Same port")
			click pop up button of group 1
			delay 1
			keystroke "a"
			keystroke return
			-- End of the non mandatory section
			click button "Allow Until Quit"
		end tell
	end tell
end tell