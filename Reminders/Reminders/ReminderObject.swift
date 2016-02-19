//
//  ReminderObject.swift
//  Reminders
//
//  Created by John Zhang on 2/19/16.
//  Copyright © 2016 John Zhang. All rights reserved.
//

import UIKit

class ReminderObject: NSObject {
    
    var theReminderTitle = ""
    
    var reminderTitle : String
    {
        get {
            return self.theReminderTitle
        }
        set (newValue) {
            self.theReminderTitle = newValue
        }
    }
    
    var theReminderDescription = ""
    
    var reminderDescription : String
    {
        get {
            return self.theReminderDescription
        }
        set {
            self.theReminderDescription = newValue
        }
    }

    var theReminderDateTime = NSDate()
    
    var reminderDateTime: NSDate
    {
        get {
            return self.theReminderDateTime
        }
        set {
            self.theReminderDateTime = newValue
        }
    }
    
    
}
