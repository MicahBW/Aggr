//
//  ViewController.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/11/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//



///        ViewController
///     GMSMapView     TableView
/// https://stackoverflow.com/questions/23301618/table-views-view-controller-vs-table-view-controller
///
///
///



import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController, GMSMapViewDelegate {
    
    
    var encompassingView: UIView!
    var mapView: GMSMapView!
    //var tableView: VehicleTableView!

    
   
    
    override func loadView() {
        
        // Deal with GMS
        let camera = GMSCameraPosition.camera(withLatitude: 38.647202, longitude: -90.310471, zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
        // Deal with VehicleTableView
       // let tableView = VehicleTableView(frame: CGRect()
        
        // Combine the two views
        
        //let ve : Vehicle = Vehicle(location: CLLocationCoordinate2DMake(38.647202, -90.310471), company: Company.bird, type: VehicleType.bike, scooterInfo: nil);
        
       // let mark : VehicleMarker = VehicleMarker(forVehicle: ve)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let vehList = getVehList()
            for veh in vehList {
                let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                thisMark.map = mapView
            }

        }
        
        //mark.map = mapView
        
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - MY FUNCTIONS AND SETTINGS
    

    


}

