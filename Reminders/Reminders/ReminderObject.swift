//
//  ReminderObject.swift
//  Reminders
//
//  Created by John Zhang on 2/19/16.
//  Copyright © 2016 John Zhang. All rights reserved.
//

import UIKit

class ReminderObject: NSObject {
    
    var reminderTitle : String {
        get {
            return self.reminderTitle
        }
        set (newValue){
            self.reminderTitle = newValue
        }
    }
    var reminderDescription : String {
        get {
            return self.reminderDescription
        }
        set (newValue){
            self.reminderDescription = newValue
        }
    }

    var reminderDateTime : NSDate {
        get {
            return self.reminderDateTime
        }
        set (newValue){
            self.reminderDateTime = newValue
        }
    }
    
    
    
}
