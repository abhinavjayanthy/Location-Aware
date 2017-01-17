//
//  ViewController.swift
//  Location Aware
//
//  Created by Abhinav Jayanthy on 1/17/17.
//  Copyright © 2017 Abhinav Jayanthy. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet var latitideLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation : CLLocation = locations[0]
        self.latitideLabel.text = String(userLocation.coordinate.latitude)
        self.longitudeLabel.text = String(userLocation.coordinate.longitude)
        self.courseLabel.text = String(userLocation.course)
        self.speedLabel.text = String(userLocation.speed)
        self.altitudeLabel.text =  String(userLocation.altitude)
        
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placeMarks, error) in
            if (error != nil){
                print(error!)
            }
            else{
                if let placeMark = placeMarks?[0]{
                    var address = ""
                    if placeMark.subThoroughfare != nil{
                        address += placeMark.subThoroughfare!+" "
                        
                    }
                    if placeMark.thoroughfare != nil{
                        address += placeMark.thoroughfare!+"\n"
                    }
                    if placeMark.subLocality != nil{
                        address += placeMark.subLocality!+"\n"
                    }
                    if placeMark.subAdministrativeArea != nil{
                       address += placeMark.subAdministrativeArea!+"\n"
                    }
                    if placeMark.postalCode != nil{
                        address += placeMark.postalCode!+"\n"
                    }
                    if placeMark.country != nil{
                        address += placeMark.country!+"\n"
                    }
                    self.addressLabel.text = address
                }
            }
        }
    }
}

