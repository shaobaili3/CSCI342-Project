//
//  SpeakersDetailViewController.swift
//  iOS-Project
//
//  Created by SABai on 23/05/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class SpeakersDetailViewController: UIViewController {

    @IBAction func twitter(sender: AnyObject) {
        followUser("tim_cook")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func followUser(username: String) {
        //Open twitter by client if you have
        let twitterURLs = [
            "twitter://user?screen_name=\(username)", // Twitter
            "tweetbot://user_profile/\(username)", // TweetBot
            "echofon://user_timeline?\(username)", // Echofon
            "twit://user?screen_name=\(username)", // Twittelator Pro
            "x-seesmic://twitter_profile?twitter_screen_name=\(username)", // Seesmic
            "x-birdfeed://user?screen_name=\(username)", // Birdfeed
            "tweetings://user?screen_name=\(username)", // Tweetings
            "simplytweet://?link=http://twitter.com/\(username)", // SimplyTweet
            "icebird://user?screen_name=\(username)", // IceBird
            "fluttr://user/\(username)", // Fluttr
        ]
        
        var applicationOpened: Bool = false
        let application = UIApplication.sharedApplication()
        for twitterURL in twitterURLs {
            if let url = NSURL(string: twitterURL) where application.canOpenURL(url) && !applicationOpened {
                application.openURL(url)
                applicationOpened = true
                break
            }
        }
        
        //If dont have client open it by safari
        if !applicationOpened {
            let url = NSURL(string: "http://twitter.com/\(username)")!
            UIApplication.sharedApplication().openURL(url)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
