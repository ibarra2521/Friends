//
//  MapViewController.swift
//  Friends
//
//  Created by Nivardo Ibarra on 12/27/15.
//  Copyright © 2015 Nivardo Ibarra. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    weak var mapView: MKMapView?
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView = MKMapView(frame: view.frame)
        mapView?.delegate = self
        mapView?.showsUserLocation = true
        view.addSubview(mapView!)
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

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 100)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(MKUserLocation.classForCoder()) {
            return nil
        }
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PinPurple")
        pin.pinTintColor = UIColor.purpleColor()
        return pin
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print(view)
//        let 
        showAlertMessage("Uppss!!!", message: "You are in lat: \(mapView.userLocation.coordinate.latitude) long \(mapView.userLocation.coordinate.longitude)", owner: self)
    }
    
    @IBAction func addPinToMap(sender: UIBarButtonItem) {
        let pin = MKPointAnnotation()
        pin.coordinate = mapView!.userLocation.coordinate
        pin.title = "Hello"
        mapView?.addAnnotation(pin)
    }
    
    func showAlertMessage (title: String, message: String, owner:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ (ACTION :UIAlertAction!)in
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
