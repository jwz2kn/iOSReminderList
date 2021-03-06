//
//  ReminderTableViewController.swift
//  Reminders
//
//  Created by Jeffery Cui on 2/19/16.
//  Copyright © 2016 John Zhang. All rights reserved.
//

import UIKit
import Foundation

class ReminderTableViewController: UITableViewController {
    var reminders: [String] = ["Do your homework", "This is a test"]
    let prefs = NSUserDefaults.standardUserDefaults()
    var objectArray = [ReminderObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if((prefs.objectForKey("TheData")) == nil){
            let data = NSKeyedArchiver.archivedDataWithRootObject(objectArray)
            prefs.setObject(data, forKey: "TheData")
            prefs.synchronize()
        }
        else{
            let decodeData = prefs.objectForKey("TheData") as! NSData
            objectArray = NSKeyedUnarchiver.unarchiveObjectWithData(decodeData) as! [ReminderObject]
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        var checkTimesTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("checkTimes"), userInfo: nil, repeats: true)
    }
    
    func checkTimes()
    {
        if(!objectArray.isEmpty){
            if(objectArray[0].reminderDateTime.compare(NSDate()) == NSComparisonResult.OrderedAscending  ){
                let alert = UIAlertController(title: "\(objectArray[0].theReminderTitle) is due",
                    message: "Postpone an hour or delete?", preferredStyle: UIAlertControllerStyle.Alert)
                
                let Delete = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Cancel) {
                    UIAlertAction in
                    NSLog("Delete pressed")
                    self.objectArray.removeFirst();
                    self.objectArray.sortInPlace({$0.reminderDateTime.compare($1.reminderDateTime) == NSComparisonResult.OrderedAscending })
                    let data = NSKeyedArchiver.archivedDataWithRootObject(self.objectArray)
                    self.prefs.setObject(data, forKey: "TheData")
                    self.prefs.synchronize()
                    self.tableView.reloadData()
                }
                let Postpone = UIAlertAction(title: "Postpone", style: UIAlertActionStyle.Default) {
                    UIAlertAction in
                    NSLog("Postpone Pressed")
                    self.objectArray[0].theReminderDateTime = self.objectArray[0].theReminderDateTime.dateByAddingTimeInterval(3600);
                    self.objectArray.sortInPlace({$0.reminderDateTime.compare($1.reminderDateTime) == NSComparisonResult.OrderedAscending })
                    let data = NSKeyedArchiver.archivedDataWithRootObject(self.objectArray)
                    self.prefs.setObject(data, forKey: "TheData")
                    self.prefs.synchronize()
                    self.tableView.reloadData()
                }
                alert.addAction(Delete)
                alert.addAction(Postpone)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        NSLog("checked")
        NSLog("\(NSDate())")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if((prefs.objectForKey("TheData")) == nil){
            let data = NSKeyedArchiver.archivedDataWithRootObject(objectArray)
            prefs.setObject(data, forKey: "TheData")
            prefs.synchronize()
        }
        else{
            let decodeData = prefs.objectForKey("TheData") as! NSData
            objectArray = NSKeyedUnarchiver.unarchiveObjectWithData(decodeData) as! [ReminderObject]
        }
//        objectArray.sortInPlace({$0.reminderDateTime.compare($1.reminderDateTime) == NSComparisonResult.OrderedAscending })
        self.tableView.reloadData()
        // NSLog("\(objectArray.count)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        NSLog("\(objectArray.count)")
        
        return objectArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RCell", forIndexPath: indexPath) as! ReminderTableViewCell
        cell.ReminderText.text = objectArray[indexPath.row].reminderTitle
        let date = objectArray[indexPath.row].reminderDateTime
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a, M/dd/YY"
        dateFormatter.AMSymbol = "AM"
        dateFormatter.PMSymbol = "PM"
        let dateAsString = dateFormatter.stringFromDate(date)
        cell.ReminderDate.text = dateAsString
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            objectArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            let data = NSKeyedArchiver.archivedDataWithRootObject(objectArray)
            prefs.setObject(data, forKey: "TheData")
            prefs.synchronize()
        }
    }
    
    
    // MARK: - Navigation
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetail", sender: indexPath)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "showDetail") {
            let controller = (segue.destinationViewController as! EnterInfoViewController)
            //let indexPath = tableView.indexPathForCell(sender as! ReminderTableViewCell)
            //let row = indexPath!.row
            let row = (sender as! NSIndexPath).row
            let detailedItem = objectArray[row]
            controller.detailReminderObject = detailedItem
            controller.detailRow = row
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

}
