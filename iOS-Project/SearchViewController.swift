//
//  SearchViewController.swift
//  iOS-Project
//
//  Created by SABai on 23/07/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBOutlet weak var searchBar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        // Do any additional setup after loading the view.
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
