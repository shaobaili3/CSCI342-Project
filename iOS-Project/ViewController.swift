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

        login()
    }
    
    //Log in
    func login()
    {
        if(username.text == "uow" || password.text == "uow")
        {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UITabBarController
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
        else{
                    let alert: UIAlertController = UIAlertController(title: "Incorrect account or password. Enter again", message: "", preferredStyle: .Alert)
            
            
                    let tryAction: UIAlertAction = UIAlertAction(title: "Retry", style: .Cancel) { action -> Void in
                    }
                    alert.addAction(tryAction)
            
                    let HELPAction: UIAlertAction = UIAlertAction(title: "Help", style: .Default) { action -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Password") as! UINavigationController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    }
                    alert.addAction(HELPAction)
            
                    alert.view.setNeedsLayout()
                    self.presentViewController(alert, animated: true, completion: nil)
            
        }

    }
    
    //when user press next and go in keyboard when whey input username and password
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.username {
            self.password.becomeFirstResponder()
        }else{
            login()
        }
        
        return true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //play video in background
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
        
        //delegator for textfield
        self.username.delegate = self
        self.password.delegate = self
        
        //tap to hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

