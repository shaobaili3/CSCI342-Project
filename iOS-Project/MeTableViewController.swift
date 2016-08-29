//
//  MeTableViewController.swift
//  iOS-Project
//
//  Created by SABai on 31/05/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class MeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.section == 1
        {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! UIViewController
                    self.presentViewController(viewController, animated: true, completion: nil)
                })
        }
    }

}
