//
//  twittertableTableViewController.swift
//  iOS-Project
//
//  Created by SABai on 2/06/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit
import TwitterKit
import Fabric

class twittertableTableViewController: UITableViewController {

    
    @IBOutlet weak var one: TWTRTweetTableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Twitter"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TWTRTweetTableViewCell
        let client = TWTRAPIClient()
        var id: String!
        switch indexPath.row {
        case 0:
            id = "737274886062624768"
            break
        case 2:
            id = "737845565594173441"
            break
        case 1:
            id = "735261735012073472"
            break
        default:
            break
        }
        client.loadTweetWithID(id) { tweet, error in
            if let t = tweet {
                cell.configureWithTweet(t)
                cell.tweetView.theme = .Dark
                cell.tweetView.showActionButtons = true
                //cell.tweetView.primaryTextColor = UIColor.yellowColor()
                //cell.tweetView.backgroundColor = UIColor.blueColor()
                
            } else {
                print("Failed to load Tweet: \(error!.localizedDescription)")
            }
        }
        
        return cell
    }
}
