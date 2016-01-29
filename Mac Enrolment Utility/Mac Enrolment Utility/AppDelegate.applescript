--
--  AppDelegate.applescript
--  Mac Enrolment Utility
--
--  Created by Gavin Pardoe on 12/03/2014.
--  Copyright © 2014 Gavin Pardoe. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
    
    -- IBOutlets
    
    property pathToResources : "NSString" -- creates property path to resoruces folder string
    property theName : "Enter Computer Name" -- bound to text window
    property theCounter : 0 -- bound to progress bar
    property statusMessage : "Enter Computer and Click Enrol to Begin" -- bound to status
    property theWindow : missing value -- used for updating the windows while running
    property isIdle : true -- used to prevent multi button presses
	
	
	on applicationWillFinishLaunching_(aNotification)
        set pathToResources to (current application's class "NSBundle"'s mainBundle()'s resourcePath()) as string -- creates path to resoruces folder as string on launch
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		return current application's NSTerminateNow
	end applicationShouldTerminate_
    
    on doProcess_(sender) -- connected to Enroll button
        
        try
            set my statusMessage to "Configuring Time Zone & SSH..."
            tell theWindow to displayIfNeeded()
            set my theCounter to 1
            do shell script "sleep 3"
            do shell script "systemsetup -setremotelogin on" with administrator privileges
            do shell script "systemsetup -settimezone Europe/London" with administrator privileges
        end try
        
        try
            set my statusMessage to "Setting Machine Name to: " & theName
            tell theWindow to displayIfNeeded()
            set my theCounter to 2
            do shell script "sleep 4"
            do shell script ("networksetup setcomputername " & theName) with administrator privileges
            do shell script ("scutil --set LocalHostName " & theName) with administrator privileges
            do shell script "sleep 2"
        end try
        
        try
            set my statusMessage to "Installing Certificates..."
            tell theWindow to displayIfNeeded()
            set my theCounter to 3
            do shell script "sleep 2"
            set myCerts to POSIX path of (path to resource "certs")
            do shell script ("bash " & quoted form of myCerts) with administrator privileges
        end try
        
        try
            set my statusMessage to "Installing xxxx Agent... Will Take a While!"
            tell theWindow to displayIfNeeded()
            set my theCounter to 4
            set myAgent to POSIX path of (path to resource "agent")
            do shell script ("bash " & quoted form of myAgent) with administrator privileges
        end try
        
        try
            set my statusMessage to "Enrollment Complete"
            tell theWindow to displayIfNeeded()
            set my theCounter to 5
            do shell script "sleep 2"
        end try
        
        try
            display dialog "Enrollment Process Finished." buttons {"Quit"} default button 1
            do shell script "killall 'Mac Enrolment Utility'"
        end try
        
    end doProcess_

	
end script