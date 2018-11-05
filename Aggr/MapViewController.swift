//
//  MapViewController.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 10/25/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class MapViewController: UIViewController, GMSMapViewDelegate {
    
    
    var encompassingView: UIView!
    var mapView: GMSMapView!
    
    
    //@IBOutlet weak var textbox: UITextView!
    //xvar textbox : UITextView!
    
    
    override func loadView() {
        
        // deal with GMS
        let camera = GMSCameraPosition.camera(withLatitude: 38.919389, longitude: -77.0278109, zoom: 15)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
        
        // add vehicle markers
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let vehList = getVehList()
            for veh in vehList {
                let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                thisMark.map = mapView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    public func addBottomSheetView() {
        
        
        var pullUpController = VehicleListViewController()
        
        addPullUpController(pullUpController, initialStickyPointOffset: 100, animated: true)
        
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc1, company: .bird, type: .scooter, scooterInfo: nil))
        
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheetView()
    }
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
