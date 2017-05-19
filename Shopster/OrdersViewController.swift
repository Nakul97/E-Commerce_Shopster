//
//  OrdersViewController.swift
//  Shopster
//
//  Created by Ishas Dikshit on 30/04/17.
//  Copyright © 2017 GetThisDone. All rights reserved.
//


import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

class OrdersViewController: UIViewController {

    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Navigation = NavigationView(frame : CGRect(x: 0, y: 0, width: 400, height: 30))
        self.navigationItem.titleView = Navigation
        
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
