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
        if(ReminderUITitle.text != "" && ReminderUIDescription.text != ""){
        let newObject = ReminderObject()
        newObject.reminderTitle = ReminderUITitle.text!
        newObject.reminderDescription = ReminderUIDescription.text!
        newObject.reminderDateTime = ReminderUIDate.date
        
        let decodeData = prefs.objectForKey("TheData") as! NSData
        var objectArray = NSKeyedUnarchiver.unarchiveObjectWithData(decodeData) as! [ReminderObject] 
        objectArray.append(newObject)
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(objectArray)
        prefs.setObject(data, forKey: "TheData")
        prefs.synchronize()
        
        navigationController?.popViewControllerAnimated(true)
        }
        else{
            let alert = UIAlertController(title: "Incomplete", message: "Please fill out the form", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
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
