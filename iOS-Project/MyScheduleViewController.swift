//
//  MyScheduleViewController.swift
//  iOS-Project
//
//  Created by SABai on 23/05/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class MyScheduleViewController: UITableViewController {

    
    let model: SessionModel = SessionModel()
    @IBOutlet weak var emptyView: UIView!
    @IBAction func goSchedule(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UITabBarController
            self.presentViewController(viewController, animated: false, completion: nil)
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let all = model.getMySchedule()
        let target = segue.destinationViewController as! SessionDetailViewController
        let row = self.tableView.indexPathForSelectedRow?.row
        target.name1 = all[row!].name
        switch(all[row!].day!)
        {
        case "1":
            target.date1 = "Tuesday,  6 December, " + all[row!].time!
            break
        case "2":
            target.date1 = "Wednesday,  7 December, " + all[row!].time!
            break
        case "3":
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
        super.viewDidLoad()
        //self.emptyView.hidden = true
        self.tableView.scrollEnabled = false
        
        //self.title = "My Schedule"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:  UIBarButtonSystemItem.Action, target:  self, action: Selector("shareButton"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func shareButton() {
        let activityViewController = UIActivityViewController(activityItems: ["context you want to share" as NSString], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: {})

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
        print("AAAAAERDSFSDFWEER")
        let line = model.getMySchedule().count
        print(line)
        if line != 0
        {
            self.emptyView.hidden = true
            self.tableView.scrollEnabled = true
        }
        return line
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MyScheduleCell

        let all = model.getMySchedule()
        print("JJJJ")
        print(indexPath.row)
        print(all[indexPath.row].topic)
        cell.topic.text = all[indexPath.row].topic
        cell.detail.text = all[indexPath.row].detail
        cell.imgLeft.image = UIImage(named: "1" + all[indexPath.row].img!)
        cell.more.text = all[indexPath.row].name! + " | " + all[indexPath.row].start! + " | " + all[indexPath.row].num!
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.img.image = UIImage(named: "2" + all[indexPath.row].img!)
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .Destructive, title: "Remove from My Schedule") { (action, indexPath) in
            print(indexPath.row)
            self.model.favoriate(self.model.getMySchedule()[indexPath.row])
            
            self.tableView.reloadData()
        }
        
        let share = UITableViewRowAction(style: .Default, title: "Share") { (action, indexPath) in
            // share item at indexPath
            let activityViewController = UIActivityViewController(activityItems: ["context you want to share" as NSString], applicationActivities: nil)
            self.presentViewController(activityViewController, animated: true, completion: {})
        }
        share.backgroundColor = UIColor.orangeColor()
            return [delete, share]
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
