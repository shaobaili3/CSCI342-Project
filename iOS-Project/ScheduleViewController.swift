//
//  ScheduleViewController.swift
//  iOS-Project
//
//  Created by SABai on 7/05/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ScheduleViewController: UITableViewController {
    
    let model: SessionModel = SessionModel()
    var currentDay: String = "1"
    @IBOutlet weak var days: UISegmentedControl!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    
    @IBAction func segmentValueChanged(sender: AnyObject) {
                switch(days.selectedSegmentIndex)
        {
        case 0:
            dateLabel.text = "Tuesday  6 December 2016"
            currentDay = "1"
            break
        case 1:
            dateLabel.text = "Wednesday  7 December 2016"
            currentDay = "2"
            break
        case 2:
            dateLabel.text = "Thursday  8 December 2016"
            currentDay = "3"
            break
        default:
            break
            
        }
        self.tableView.reloadData()

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let all = model.getByDay(currentDay)
        let target = segue.destinationViewController as! SessionDetailViewController
        let row = self.tableView.indexPathForSelectedRow?.row
        target.name1 = all[row!].name
        switch(days.selectedSegmentIndex)
        {
        case 0:
            target.date1 = "Tuesday,  6 December, " + all[row!].time!
            break
        case 1:
            target.date1 = "Wednesday,  7 December, " + all[row!].time!
            break
        case 2:
            target.date1 = "Thursday,  8 December, " + all[row!].time!
            break
        default:
            break
        }
        target.number1 = "Session" + all[row!].num!
        target.topic1 = all[row!].topic
        target.detail1 = all[row!].detail
        target.img1 = all[row!].img
    }
    
    override func viewDidLoad() {
        
        //print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
        
        //delete line between naviation bar and view
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

        return model.getByDay(currentDay).count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SessionCell
        

        // Configure the cell...
        let all = model.getByDay(currentDay)
        cell.topic.text = all[indexPath.row].topic
        cell.detail.text = all[indexPath.row].detail
        cell.imgLeft.image = UIImage(named: "1" + all[indexPath.row].img!)
        cell.more.text = all[indexPath.row].name! + " | " + all[indexPath.row].start! + " | " + all[indexPath.row].num!
        if all[indexPath.row].my == true
        {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            //cell.accessoryView?.hidden
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let add = UITableViewRowAction(style: .Default, title: "Add to My Schedule") { (action, indexPath) in
            self.model.favoriate(self.model.getByDay(self.currentDay)[indexPath.row])
            self.tableView.reloadData()
        }
        
        let delete = UITableViewRowAction(style: .Destructive, title: "Remove from My Schedule") { (action, indexPath) in
            print(indexPath.row)
            self.model.favoriate(self.model.getByDay(self.currentDay)[indexPath.row])
            
            self.tableView.reloadData()
        }
        
        let share = UITableViewRowAction(style: .Default, title: "Share") { (action, indexPath) in
            // share item at indexPath
            let activityViewController = UIActivityViewController(activityItems: ["context you want to share" as NSString], applicationActivities: nil)
            self.presentViewController(activityViewController, animated: true, completion: {})
        }
        add.backgroundColor = UIColor.lightGrayColor()
        share.backgroundColor = UIColor.orangeColor()
        let all = model.getByDay(currentDay)
        if ((all[indexPath.row].my) == true)
        {
            return [delete, share]
        }
        else
        {
            return [share, add]
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            // Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
    

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
