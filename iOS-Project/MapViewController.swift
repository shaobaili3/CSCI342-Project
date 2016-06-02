//
//  MapViewController.swift
//  iOS-Project
//
//  Created by SABai on 29/05/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //share button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:  UIBarButtonSystemItem.Action, target:  self, action: Selector("shareButton"))

        
        // Set MapView
        let initialLocation = CLLocationCoordinate2DMake(Double(-34.4054039), Double(150.8762413))
        let span = MKCoordinateSpanMake(0.020, 0.020)
        let region = MKCoordinateRegion(center: initialLocation, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation
        annotation.title = "University of Wollongong"
        annotation.subtitle = "ACIS Conference"
        map.addAnnotation(annotation)
        
        // Do any additional setup after loading the view.
    }

    func shareButton() {
        let activityViewController = UIActivityViewController(activityItems: ["Northfields Ave, Wollongong NSW 2522, Australia" as NSString], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: {})
        
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
