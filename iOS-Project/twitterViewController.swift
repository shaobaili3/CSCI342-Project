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


class twitterViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //https://twitter.com/BuzzNutDesign/timelines/738556083229204480
        let client = TWTRAPIClient()
        self.dataSource = TWTRCollectionTimelineDataSource(collectionID: "738556083229204480", APIClient: client)

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
