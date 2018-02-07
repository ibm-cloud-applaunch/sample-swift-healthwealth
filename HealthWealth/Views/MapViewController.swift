    //
//  MapViewController.swift
//  HealthWealth
//
//  Created by Vittal Pai on 2/5/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    let homeLocation = CLLocation(latitude: 12.949343, longitude: 77.644764)
    let regionRadius: CLLocationDistance = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = MenuItems.backgroundColor
        mapView.showsUserLocation = true
        centerMapOnLocation(location: homeLocation)
    }
    
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func deliverBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Order Successful.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationView") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
        }))
        self.present(alert, animated: true)
    }

}
