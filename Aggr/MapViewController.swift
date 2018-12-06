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
    
    var alreadyDisplayed = Set<Vehicle>()
    var encompassingView: UIView!
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var pullUpController = VehicleListViewController()
    var sortState: String = "Both"
    
    let tws = ThreeWaySwitch(frame: CGRect(x: 16, y: 670, width: 80, height: 35))
    
    //var showState
    
    
    override func loadView() {
    
        // deal with GMS
        let camera = GMSCameraPosition.camera(withLatitude: 38.89509248686296, longitude: -77.03707623761149, zoom: 15)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = self
        mapView.padding.bottom = 100
        mapView.StylizeForStyleMode(mode: MapStyleModes.Night)
        self.view = mapView
        
        
        locationManager.requestWhenInUseAuthorization()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        
        
        switch(CLLocationManager.authorizationStatus()) {
        case .authorizedWhenInUse:
            print("Authorized Always")
            locationManager.startUpdatingLocation()
            break
        default:
            print("No Location Authorization")
            break
        }
        
        // add vehicle markers
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let vehList = getVehList()
            for veh in vehList {
                let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                thisMark.map = self.mapView
            }
            self.pullUpController.addToList(newVehicles: Array(vehList).sorted(by: {$0.distanceFromUser < $1.distanceFromUser}))
        }
        
        
        
        //MARK: -  Cycle BUTTON
        
        /*
        let button = UIButton(frame: CGRect(x: 50, y: 600, width: 100, height: 50))
        button.backgroundColor = .blue
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 20
        self.view.addSubview(button)
        */
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            mapView.StylizeForStyleMode(mode: MapStyleModes.Christmas)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            mapView.StylizeForStyleMode(mode: MapStyleModes.Day)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            mapView.StylizeForStyleMode(mode: MapStyleModes.Night)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            mapView.StylizeForStyleMode(mode: MapStyleModes.Christmas)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            mapView.StylizeForStyleMode(mode: MapStyleModes.Day)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 18) {
            mapView.StylizeForStyleMode(mode: MapStyleModes.Night)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 21) {
            mapView.StylizeForStyleMode(mode: MapStyleModes.Christmas)
         }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 24) {
            mapView.StylizeForStyleMode(mode: MapStyleModes.Day)
        }
        */
        
        
        mapView.settings.consumesGesturesInView = false

    
        tws.leftView.image = #imageLiteral(resourceName: "BikeIcon")
        tws.rightView.image = #imageLiteral(resourceName: "ScooterIcon")
        
        tws.isUserInteractionEnabled = true
        
        self.view.addSubview(tws)
        self.view.bringSubview(toFront: tws)
        
        tws.didGoRightAction = onlyScooters
        tws.didGoLeftAction = onlyBikes
        tws.didGoMiddleAction = bothBikesAndScooters
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func addBottomSheetView() {
        addPullUpController(pullUpController, initialStickyPointOffset: 100, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheetView()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        let lat: Double = cameraPosition.target.latitude
        let long: Double = cameraPosition.target.longitude
        let CLLC2D: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
        var vehListSort: [Vehicle] = []
        makeAPICall(ofLocation: CLLC2D)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let vehList = getVehList()
            if (self.sortState == "Scooters") {
                for veh in vehList {
                    let coordinatePin = CLLocation(latitude: veh.location.latitude, longitude: veh.location.longitude)
                    let coordinateCamera = CLLocation(latitude: cameraPosition.target.latitude, longitude: cameraPosition.target.longitude)
                    let distanceInMeters = coordinatePin.distance(from: coordinateCamera) // result is in meters
                    let distanceInMiles = distanceInMeters/1609.344
                    veh.distance = distanceInMiles
                    if (veh.type == VehicleType.scooter){
                        vehListSort.append(veh)
                        if(!self.alreadyDisplayed.contains(veh)){
                            let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                            thisMark.map = mapView
                            self.alreadyDisplayed.insert(veh)
                        }
                    }
                }
                self.pullUpController.updateList(withVehicles: Array(vehListSort).sorted(by: {Float($0.distanceFromUser) < Float($1.distanceFromUser)}))
                
            } else if (self.sortState == "Bikes") {
                for veh in vehList {
                    let coordinatePin = CLLocation(latitude: veh.location.latitude, longitude: veh.location.longitude)
                    let coordinateCamera = CLLocation(latitude: cameraPosition.target.latitude, longitude: cameraPosition.target.longitude)
                    let distanceInMeters = coordinatePin.distance(from: coordinateCamera) // result is in meters
                    let distanceInMiles = distanceInMeters/1609.344
                    veh.distance = distanceInMiles
                    if (veh.type != VehicleType.scooter){
                        vehListSort.append(veh)
                        if(!self.alreadyDisplayed.contains(veh)){
                            let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                            thisMark.map = mapView
                            self.alreadyDisplayed.insert(veh)
                        }
                    }
                }
                self.pullUpController.updateList(withVehicles: Array(vehListSort).sorted(by: {Float($0.distanceFromUser) < Float($1.distanceFromUser)}))

            } else {
                for veh in vehList {
                    let coordinatePin = CLLocation(latitude: veh.location.latitude, longitude: veh.location.longitude)
                    let coordinateCamera = CLLocation(latitude: cameraPosition.target.latitude, longitude: cameraPosition.target.longitude)
                    let distanceInMeters = coordinatePin.distance(from: coordinateCamera) // result is in meters
                    let distanceInMiles = distanceInMeters/1609.344
                    veh.distance = distanceInMiles
                    if(!self.alreadyDisplayed.contains(veh)){
                        let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                        thisMark.map = mapView
                        self.alreadyDisplayed.insert(veh)
                    }
                }
                self.pullUpController.updateList(withVehicles: Array(vehList).sorted(by: {Float($0.distanceFromUser) < Float($1.distanceFromUser)}))

            }
        }
    }
    
    func onlyScooters() -> Void {
        sortState = "Scooters"
        mapView.clear()
        let vehList = getVehList()
        var vehListOnlyScooters: [Vehicle] = []
        self.alreadyDisplayed = Set.init()
        for veh in vehList {
            if(!self.alreadyDisplayed.contains(veh) && (veh.type == VehicleType.scooter)){
                let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                thisMark.map = mapView
                self.alreadyDisplayed.insert(veh)
                vehListOnlyScooters.append(veh)
            }
        }
        
        self.pullUpController.updateList(withVehicles: Array(vehListOnlyScooters).sorted(by: {Float($0.distanceFromUser) < Float($1.distanceFromUser)}))
    }
    
    func onlyBikes() -> Void {
        sortState = "Bikes"
        mapView.clear()
        let vehList = getVehList()
        var vehListOnlyBikes: [Vehicle] = []
        self.alreadyDisplayed = Set.init()
        for veh in vehList {
            if(!self.alreadyDisplayed.contains(veh) && (veh.type != VehicleType.scooter)){
                let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                thisMark.map = mapView
                self.alreadyDisplayed.insert(veh)
                vehListOnlyBikes.append(veh)
            }
        }
        
        self.pullUpController.updateList(withVehicles: Array(vehListOnlyBikes).sorted(by: {Float($0.distanceFromUser) < Float($1.distanceFromUser)}))
    }
    
    func bothBikesAndScooters() -> Void {
        sortState = "Both"
        mapView.clear()
        let vehList = getVehList()
        self.alreadyDisplayed = Set.init()
        for veh in vehList {
            if(!self.alreadyDisplayed.contains(veh)){
                let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                thisMark.map = mapView
                self.alreadyDisplayed.insert(veh)
            }
        }
        
        self.pullUpController.updateList(withVehicles: Array(vehList).sorted(by: {Float($0.distanceFromUser) < Float($1.distanceFromUser)}))
    }
    
    
}



