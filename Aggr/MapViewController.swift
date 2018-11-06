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
    var locationManager = CLLocationManager()
    
    //@IBOutlet weak var textbox: UITextView!
    //xvar textbox : UITextView!
    
    
    override func loadView() {
        
        // deal with GMS
        let camera = GMSCameraPosition.camera(withLatitude: 38.89509248686296, longitude: -77.03707623761149, zoom: 15)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = self
        self.view = mapView
        
        locationManager.requestWhenInUseAuthorization()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        print("is location enabled?")
        print(mapView.isMyLocationEnabled)
        switch(CLLocationManager.authorizationStatus()) {
        case .authorizedWhenInUse:
            print("authorized always")
            locationManager.startUpdatingLocation()
            break
        default:
            print("oops no location authorization")
            break
        }
        
        // add vehicle markers
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
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
        
        var i1 = pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc1, company: .bird, type: .scooter, scooterInfo: nil))
        
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            pullUpController.removeListItem(i1)
        }
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheetView()
    }
    
//    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
//        print("in move")
//        mapView.clear()
//    }
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        print("in idle")
        let lat: Double = cameraPosition.target.latitude
        let long: Double = cameraPosition.target.longitude
        let CLLC2D: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
        makeAPICall(ofLocation: CLLC2D)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let vehList = getVehList()
            for veh in vehList {
                let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                thisMark.map = mapView
            }
        }
    }
}
