//
//  FilterTableViewController.swift
//  iOS-Project
//
//  Created by SABai on 16/07/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {

    var selectedIndex:Int = 0
    
    @IBAction func Cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    @IBAction func Done(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.section == 0
        {
            let index = selectedIndex
            let PreviousCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            PreviousCell?.accessoryType = .None

            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell?.accessoryType = .Checkmark
            selectedIndex = indexPath.row
        }
    }
}
