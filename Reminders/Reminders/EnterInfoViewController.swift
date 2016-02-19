//
//  EnterInfoViewController.swift
//  Reminders
//
//  Created by Jeffery Cui on 2/19/16.
//  Copyright © 2016 John Zhang. All rights reserved.
//

import UIKit

class EnterInfoViewController: UIViewController {

    @IBOutlet weak var ReminderUITitle:UITextField!
    @IBOutlet weak var ReminderUIDescription:UITextField!
    @IBOutlet weak var ReminderUIDate:UIDatePicker!
    @IBOutlet weak var SubmitButton:UIButton!
    let prefs = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SubmitButton(sender: AnyObject) {
        let newObject = ReminderObject()
        newObject.reminderTitle = ReminderUITitle.text!
        newObject.reminderDescription = ReminderUIDescription.text!
        newObject.reminderDateTime = ReminderUIDate.date
        var ObjectArray = prefs.arrayForKey("TheArray") as! [ReminderObject]
        ObjectArray.append(newObject)
        prefs.setValue(ObjectArray, forKey: "TheArray")
        prefs.synchronize()
        navigationController?.popViewControllerAnimated(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
