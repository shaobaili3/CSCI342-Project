//
//  ViewController.swift
//  iOS-Project
//
//  Created by SABai on 7/05/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController:Background, UITextFieldDelegate {


    let model: SessionModel = SessionModel()
    
    @IBOutlet weak var allViews: UIStackView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var forgot: UIStackView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func pressLogin(sender: AnyObject) {

        login()
    }
    //Log in
    func login()
    {
        
      allViews.hidden = true
        indicator.startAnimating()
 dispatch_async(dispatch_get_main_queue(), { () -> Void in
        FIRAuth.auth()?.signInWithEmail(self.username.text!, password: self.password.text!) { (user, error) in
            if(error == nil)
            {
                self.model.deleteAllData("Session") // delte all data in database
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //retrieve Json string from firebase database
                    let ref = FIRDatabase.database().reference()
                    ref.observeEventType(FIRDataEventType.Value, withBlock:  { (snapshot) in
                        let all = snapshot.childSnapshotForPath("sessions").value as! NSDictionary
                        for one in all
                        {
                            
                            let json = one.value as! NSDictionary
                            let name: String = (json["name"] as? String)!
                            let tempDay = json["day"]!
                            let day: String! = String(tempDay)
                            let detail: String = (json["detail"] as? String)!
                            let i: Int = (json["i"] as? Int)!
                            let img: String = (json["img"] as? String)!
                            let img2: String = (json["img2"] as? String)!
                            let num: String = (json["num"] as? String)!
                            let start: String = (json["start"] as? String)!
                            let time: String = (json["time"] as? String)!
                            let topic: String = (json["topic"] as? String)!
                            
                            let my: Bool = false
                            self.model.CreateCollec(name, day: day, detail: detail, i: i, img: img, img2: img2, my: my, num: num, time: time, start: start, topic: topic)
                        }
                        
                        print(self.model.GetSessions())
                        print(self.model.GetSessions().count)
                        self.indicator.stopAnimating()
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UITabBarController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                    
                //switch to viewController


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
                self.indicator.stopAnimating()
                self.allViews.hidden = false
            }
            
        }
        })
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

