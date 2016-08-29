//
//  MapBoxViewController.swift
//  iOS-Project
//
//  Created by SABai on 26/08/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit
import Mapbox
import MapboxGeocoder


class MapBoxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MGLMapViewDelegate {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var text: UITextField!
    let MapboxAccessToken = "pk.eyJ1Ijoic3Rvcm0zIiwiYSI6ImNpc2EyM3FwMjAwNnYyeHBhZGRiOXhkczQifQ.2BxYkSBJ6gYK_4kUvsa2hA"
    let customMark: String = "building uow wollongong"
    var tap: UITapGestureRecognizer!
    var geocoder: Geocoder!
    var map: MGLMapView!
    var rowNum: Int! = 0
    var tableContent: [String] = []
    var token: dispatch_once_t = 0
    var place: [GeocodedPlacemark]! = []
    let newMarker = MGLPointAnnotation()
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        //tap to hide keyboard
        tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        print(self.map.gestureRecognizers?.count)
        //self.map.removeGestureRecognizer(tap)
        self.map.addGestureRecognizer(tap)
        textFieldDidChange(text)


        return true
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        dismissKeyboard()
        return false
    }
    
    func textFieldDidChange(textField: UITextField) {
        
        print(self.map.gestureRecognizers?.count)
        
        print(text.text)
        if text.text == "" || text.text == "0"
        {
            rowNum = 0
            table.reloadData()
            table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, table.contentSize.height)
            //self.map.removeGestureRecognizer(tap)
            return
        }
        let options = ForwardGeocodeOptions(query: text.text!)
        geocoder = Geocoder(accessToken: MapboxAccessToken)        // To refine the search, you can set various properties on the options object.
        options.allowedISOCountryCodes = ["AU"] //AU
        options.focalLocation = CLLocation(latitude: -34.4054039, longitude: 150.8762413)
        //options.allowedScopes = [.Address, .PointOfInterest]
        let task = geocoder.geocode(options: options) { (placemarks, attribution, error) in
            //let placemark = placemarks![0]

            //print("_______")
            //print(placemark.name)
            // 200 Queen St
            //print(placemark.qualifiedName)
            // 200 Queen St, Saint John, New Brunswick E2L 2X1, Canada
            
            //let coordinate = placemark.location.coordinate
            //print("\(coordinate.latitude), \(coordinate.longitude)")
            // 45.270093, -66.050985
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.place = placemarks
                self.token = 0
                self.tableContent = []
                //self.rowNum = placemarks?.count
                
                //add custom marks to the text field
                if self.customMark.rangeOfString((self.text.text?.lowercaseString)!) != nil {
                    print("exists!!")
                    print(self.customMark.rangeOfString((self.text.text?.lowercaseString)!))
                    self.tableContent.append("Building 11, University of Wollongong")
                    self.tableContent.append("Building 6, University of Wollongong")
                }
                if self.place.count != 0{
                    for a in placemarks!
                    {
                        print(a.qualifiedName)
                        self.tableContent.append(a.qualifiedName)
                    }
                }
                self.rowNum = self.tableContent.count
            })
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.0 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                dispatch_once(&self.token) {
                    self.table.reloadData()
                    self.table.frame = CGRectMake(self.table.frame.origin.x, self.table.frame.origin.y, self.table.frame.size.width, self.table.contentSize.height)
                    print("***********")
                    print(self.token)
                }

            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        text.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        table.delegate = self
        table.dataSource = self
        text.delegate = self
        map = MGLMapView(frame: view.bounds)
        map.setCenterCoordinate(CLLocationCoordinate2D(latitude: -34.4054039, longitude: 150.8762413),
                                zoomLevel: 15,
                                animated: false)
        
        
        map.delegate = self
        self.view.insertSubview(map, belowSubview: text)
        let marker = MGLPointAnnotation()
        marker.coordinate = map.centerCoordinate
        marker.title = "My Marker"
        marker.subtitle = "uow"
        map.addAnnotation(marker)
        map.selectAnnotation(marker, animated: true)
        
        let marker2 = MGLPointAnnotation()
        marker2.coordinate = CLLocationCoordinate2D(latitude: -34.406, longitude: 150.879)
        marker2.title = "My Marker2"
        marker2.subtitle = "location"
        map.addAnnotation(marker2)

    }
    
    func mapView(mapView: MGLMapView, imageForAnnotation annotation: MGLAnnotation) -> MGLAnnotationImage?
    {
        print("haha")
        var image = UIImage(named: "home")
        var annotationImage = map.dequeueReusableAnnotationImageWithIdentifier("new")
        annotationImage = MGLAnnotationImage(image: image!, reuseIdentifier: "new")
        if(newMarker.isEqual(annotation as! MGLPointAnnotation)  )
        {
            return nil
        }
        else{
            return annotationImage
        }
        
    }
    
    // Allow callout view to appear when an annotation is tapped.
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, table.contentSize.height)
        table.scrollEnabled = false
    }
    
    override func viewDidLayoutSubviews(){
        //table.reloadData()
        table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, table.contentSize.height)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowNum;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        print("why??")
        //cell.textLabel!.text = "aa"
        cell.textLabel?.text = tableContent[indexPath.row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        text.text = tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.text //set textfield label to autoComplete
        if rowNum == place.count{
        newMarker.coordinate = place[indexPath.row].location.coordinate
        newMarker.title = "new"
        newMarker.subtitle = "new"
        map.addAnnotation(newMarker)
        map.setCenterCoordinate(newMarker.coordinate,
                                zoomLevel: 15,
                                animated: true)
        }
        else
        {
            map.setCenterCoordinate(CLLocationCoordinate2D(latitude: -34.4054039, longitude: 150.8762413),
                                    zoomLevel: 15,
                                    animated: false)
        }
        dismissKeyboard()
    }

    func dismissKeyboard() {
        print(self.map.gestureRecognizers?.count)
        //self.map.removeGestureRecognizer(tap)
                //print(self.map.gestureRecognizers)
        //print(self.map.gestureRecognizers?.count)
        //self.tap.requireGestureRecognizerToFail(<#T##otherGestureRecognizer: UIGestureRecognizer##UIGestureRecognizer#>)
        //tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        //print(self.map.removeGestureRecognizer(tap))
        //print(self.map.gestureRecognizers?.count)
        for g in self.map.gestureRecognizers!
        {
            if (g == tap)
            {
                self.map.removeGestureRecognizer(g)
            }
        }
        print(self.map.gestureRecognizers?.count)
        print("dismisskeyboard")
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        rowNum = 0
        table.reloadData()
        table.frame = CGRectMake(table.frame.origin.x, table.frame.origin.y, table.frame.size.width, table.contentSize.height)    }
}
