//
//  ReminderObject.swift
//  Reminders
//
//  Created by John Zhang on 2/19/16.
//  Copyright © 2016 John Zhang. All rights reserved.
//

import UIKit

class ReminderObject: NSObject, NSCoding {
    
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
    
    override init() {
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        self.reminderTitle = aDecoder.decodeObjectForKey("ReminderTitle") as! String
        self.reminderDescription = aDecoder.decodeObjectForKey("ReminderDescription") as! String
        self.reminderDateTime = aDecoder.decodeObjectForKey("ReminderDateTime") as! NSDate
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(reminderTitle, forKey: "ReminderTitle")
        aCoder.encodeObject(reminderDescription, forKey: "ReminderDescription")
        aCoder.encodeObject(reminderDateTime, forKey: "ReminderDateTime")

    }
    
    
    
}
