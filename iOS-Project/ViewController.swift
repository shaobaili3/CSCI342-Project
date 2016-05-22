//
//  ViewController.swift
//  iOS-Project
//
//  Created by SABai on 7/05/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class ViewController:Background, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func pressLogin(sender: AnyObject) {
//        let alert: UIAlertController = UIAlertController(title: "Not a valid location!", message: "Please reselect a valid location", preferredStyle: .Alert)
//        
//        //Create and add the Cancel action
//        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
//        alert.addAction(cancelAction)
//        alert.view.setNeedsLayout()
//        self.presentViewController(alert, animated: true, completion: nil)
        
        
//        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UITabBarController
//            self.presentViewController(viewController, animated: true, completion: nil)
//        })

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("test", ofType: "mp4")!)
        let video = NSBundle.mainBundle().pathForResource("Login", ofType:"mp4")
        print(video)
        let url = NSURL.fileURLWithPath(video!)
        self.videoFrame = view.frame
        self.fillMode = .ResizeAspectFill
        self.alwaysRepeat = true
        self.sound = true
        self.startTime = 12.0
        self.duration = 4.0
        self.alpha = 0.7
        self.backgroundColor = UIColor.blackColor()
        self.contentURL = url
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

