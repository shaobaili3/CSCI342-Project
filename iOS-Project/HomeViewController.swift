//
//  HomeViewController.swift
//  iOS-Project
//
//  Created by SABai on 25/07/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var viewWeb: UIButton!
    @IBOutlet weak var table: UITableView!
    
    @IBAction func segmentValueChanged(sender: AnyObject) {
        switch(segment.selectedSegmentIndex)
        {
        case 0:
            table.hidden = true
            break
        case 1:
            table.hidden = false
            break
        default:
            break
            
        }

    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        // Do any additional setup after loading the view.
        //viewWeb.layer.borderWidth = 1
        viewWeb.layer.cornerRadius = 5
        
        //add swipe gestrue for top image
        topImage.userInteractionEnabled = true
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: "swipeGesture:")
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: "swipeGesture:")
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.topImage.addGestureRecognizer(rightSwipe)
        self.topImage.addGestureRecognizer(leftSwipe)
        
    }
    
    func swipeGesture(gesture: UISwipeGestureRecognizer)
    {
        if gesture.direction == UISwipeGestureRecognizerDirection.Left{
            print("left")
            topImage.image = UIImage(named: "example2")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.Right{
            print("right")
            topImage.image = UIImage(named: "example")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.imageView?.image = UIImage(named: "Cook-DESKTOP-QBKVQDI")
        cell.textLabel?.text = "Jonathan Ive"
        cell.detailTextLabel?.text = "consectetaur cillium adipisicing."
        
        return cell
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
