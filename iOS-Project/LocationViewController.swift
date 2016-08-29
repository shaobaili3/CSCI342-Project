//
//  LocationViewController.swift
//  iOS-Project
//
//  Created by SABai on 28/08/2016.
//  Copyright © 2016 Shaobai Li. All rights reserved.
//

import UIKit
import Mapbox
import MapboxDirections

class LocationViewController: UIViewController, MGLMapViewDelegate {
    var map: MGLMapView!
    let marker = MGLPointAnnotation()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D!
    var conferenceLocation: CLLocationCoordinate2D!
    let directions = Directions(accessToken: "pk.eyJ1Ijoic3Rvcm0zIiwiYSI6ImNpc2EyM3FwMjAwNnYyeHBhZGRiOXhkczQifQ.2BxYkSBJ6gYK_4kUvsa2hA")
    override func viewDidLoad() {
        super.viewDidLoad()
        //add map view
        map = MGLMapView(frame: view.bounds)
        map.setCenterCoordinate(CLLocationCoordinate2D(latitude: -34.4054039, longitude: 150.8762413),
                                zoomLevel: 15,
                                animated: false)
        map.delegate = self
        self.view.addSubview(map)
        
        //add conference location mark
        conferenceLocation = CLLocationCoordinate2D(latitude: -34.4054039, longitude: 150.8762413)
        marker.coordinate = conferenceLocation
        marker.title = "conference"
        marker.subtitle = "uow"
        map.addAnnotation(marker)
        map.selectAnnotation(marker, animated: true)
        
        
        

        
        
        //GET Current LOCATION
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        //Upate current location
        print("lollol!!!!!!!!!!!!!!!!!")
        if (locationManager.location != nil)
        {
            let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            currentLocation = locValue
            
        //add conference location mark
        let marker2 = MGLPointAnnotation()
        marker2.coordinate = currentLocation
        marker2.title = "currentLocation"
        marker2.subtitle = "uow"
        map.addAnnotation(marker2)
            

        
        let waypoints = [
            Waypoint(coordinate: CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude), name: "Mapbox"),
            Waypoint(coordinate: conferenceLocation, name: "White House"),
            ]
        print("haha = \(locValue.latitude) \(locValue.longitude)")
        let options = RouteOptions(waypoints: waypoints, profileIdentifier: MBDirectionsProfileIdentifierAutomobile)
        options.includesSteps = true
        
        let task = directions.calculateDirections(options: options) { (waypoints, routes, error) in
            guard error == nil else {
                print("Error calculating directions: \(error!)")
                return
            }
            
            if let route = routes?.first, leg = route.legs.first {
                print("Route via \(leg):")
                
                let distanceFormatter = NSLengthFormatter()
                let formattedDistance = distanceFormatter.stringFromMeters(route.distance)
                
                let travelTimeFormatter = NSDateComponentsFormatter()
                travelTimeFormatter.unitsStyle = .Short
                let formattedTravelTime = travelTimeFormatter.stringFromTimeInterval(route.expectedTravelTime)
                
                print("Distance: \(formattedDistance); ETA: \(formattedTravelTime!)")
                
                for step in leg.steps {
                    print("\(step.instructions)")
                    let formattedDistance = distanceFormatter.stringFromMeters(step.distance)
                    print("— \(formattedDistance) —")
                }
                
                if route.coordinateCount > 0 {
                    // Convert the route’s coordinates into a polyline.
                    var routeCoordinates = route.coordinates!
                    let routeLine = MGLPolyline(coordinates: &routeCoordinates, count: route.coordinateCount)
                    
                    // Add the polyline to the map and fit the viewport to the polyline.
                    self.map.addAnnotation(routeLine)
                    self.map.setVisibleCoordinates(&routeCoordinates, count: route.coordinateCount, edgePadding: UIEdgeInsetsZero, animated: true)
                }
            }
        }
        

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func mapView(mapView: MGLMapView, imageForAnnotation annotation: MGLAnnotation) -> MGLAnnotationImage?
    {
        print("haha!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        var image = UIImage(named: "home")
        var annotationImage = map.dequeueReusableAnnotationImageWithIdentifier("new")
        annotationImage = MGLAnnotationImage(image: image!, reuseIdentifier: "new")
        if(marker.isEqual(annotation as! MGLPointAnnotation)  )
        {
            return annotationImage
        }
        else{
            print("haha")
            return nil
        }
        
    }
    
    // Allow callout view to appear when an annotation is tapped.
    func mapView(mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
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
