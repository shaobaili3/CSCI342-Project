//
//  SessionDetailViewController.swift
//  iOS-Project
//
//  Created by SABai on 31/05/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class SessionDetailViewController: UIViewController {

    var topic1: String!
    var date1 : String!
    var img1 :String!
    var name1 : String!
    var number1 : String!
    var detail1 : String!
    
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var detail: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //return all front
//        for familyName in UIFont.familyNames() {
//            for fontName in UIFont.fontNamesForFamilyName(familyName) {
//                print(fontName)
//            }
//        }
        
        topic.text = topic1
        date.text = date1
        print(img1)
        img.image = UIImage(named: img1)
        name.text = name1
        number.text = number1
        detail.text = detail1
        detail.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        self.title = "Session"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:  UIBarButtonSystemItem.Action, target:  self, action: Selector("shareButton"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareButton() {
        let activityViewController = UIActivityViewController(activityItems: [topic1 as NSString], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: {})
        
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
