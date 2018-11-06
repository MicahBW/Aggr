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
    
    var callCount = 0
    var encompassingView: UIView!
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var pullUpController = VehicleListViewController()
    
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
            self.pullUpController.addToList(newVehicles: Array(vehList).sorted(by: {$0.distanceFromUser < $1.distanceFromUser}))
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    public func addBottomSheetView() {
        
        
        //var pullUpController = VehicleListViewController()
        
        addPullUpController(pullUpController, initialStickyPointOffset: 100, animated: true)
        
        
        /*
        var i1 = pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc1, company: .bird, type: .scooter, scooterInfo: nil))
        
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))
        pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.pullUpController.updateList(withVehicles: [Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .limeBike , type: .scooter, scooterInfo: nil)])
            print("REPLACING")
        }
        */

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
        mapView.clear()
        print("in idle")
        print(callCount)
        callCount = callCount + 1;
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
            //self.pullUpController.addToList(newVehicles: Array(vehList))
            self.pullUpController.updateList(withVehicles: Array(vehList).sorted(by: {Float($0.distanceFromUser) < Float($1.distanceFromUser)}))
            //self.pullUpController.deleteAllListItems()
            //pullUp
            //self.pullUpController.addItemForVehicle(Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: .bird, type: .scooter, scooterInfo: nil))

        }
    }
}



/*
func putInAscendingOrder(_ inArray: [Vehicle]) -> [Vehicle] {
    var ret = [Vehicle]()
    //ret.insertA
    
    
}
*/
