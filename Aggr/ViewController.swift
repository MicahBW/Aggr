//
//  ViewController.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/11/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, GMSMapViewDelegate {
    
    var mapView: GMSMapView!
    
    override func loadView() {
        
        let camera = GMSCameraPosition.camera(withLatitude: 1.285, longitude: 103.848, zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView

        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

