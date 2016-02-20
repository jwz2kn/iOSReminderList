//
//  ReminderTableViewController.swift
//  Reminders
//
//  Created by Jeffery Cui on 2/19/16.
//  Copyright © 2016 John Zhang. All rights reserved.
//

import UIKit

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
        self.tableView.reloadData()

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
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
