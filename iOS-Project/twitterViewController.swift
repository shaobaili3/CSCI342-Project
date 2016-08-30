//
//  twitterViewController.swift
//  iOS-Project
//
//  Created by SABai on 3/06/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit
import TwitterKit
import Fabric


class twitterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Twitter"
        
        self.view.backgroundColor = UIColor.grayColor()
        TWTRAPIClient().loadTweetWithID("737845565594173441") { (tweet, error) in
            if let unwrappedTweet = tweet {
                let tweetView = TWTRTweetView(tweet: unwrappedTweet)
                //tweetView.center = CGPointMake(self.view.center.x, self.topLayoutGuide.length + tweetView.frame.size.height / 2);
                tweetView.configureWithTweet(tweet)
                tweetView.showActionButtons = true
                var test = TWTRTweetView(tweet: tweet, style: .Regular)
                test.center = CGPointMake(self.view.center.x,180)
                test.configureWithTweet(tweet)
                test.showActionButtons = true
                self.view.addSubview(test)
            } else {
                NSLog("Tweet load error: %@", error!.localizedDescription);
            }
        }
        
        TWTRAPIClient().loadTweetWithID("769218876286480384") { (tweet, error) in
            if let unwrappedTweet = tweet {
                let tweetView = TWTRTweetView(tweet: unwrappedTweet)
                tweetView.center = CGPointMake(self.view.center.x, 600 + tweetView.frame.size.height / 2);
                tweetView.configureWithTweet(tweet)
                tweetView.showActionButtons = true
                var test = TWTRTweetView(tweet: tweet, style: .Regular)
                test.center = CGPointMake(self.view.center.x, 410 + tweetView.frame.size.height / 2)
                test.configureWithTweet(tweet)
                test.showActionButtons = true
                self.view.addSubview(test)
            } else {
                NSLog("Tweet load error: %@", error!.localizedDescription);
            }
        }
        
        TWTRAPIClient().loadTweetWithID("769218876286480384") { (tweet, error) in
            if let unwrappedTweet = tweet {
                let tweetView = TWTRTweetView(tweet: unwrappedTweet)
                tweetView.center = CGPointMake(self.view.center.x, 600 + tweetView.frame.size.height / 2);
                tweetView.configureWithTweet(tweet)
                tweetView.showActionButtons = true
                var test = TWTRTweetView(tweet: tweet, style: .Regular)
                test.center = CGPointMake(self.view.center.x, 730 + tweetView.frame.size.height / 2)
                test.configureWithTweet(tweet)
                test.showActionButtons = true
                self.view.addSubview(test)
            } else {
                NSLog("Tweet load error: %@", error!.localizedDescription);
            }
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
