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
    var callCount = 0
    var encompassingView: UIView!
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var pullUpController = VehicleListViewController()
    
    override func loadView() {
        
        // deal with GMS
        let camera = GMSCameraPosition.camera(withLatitude: 38.89509248686296, longitude: -77.03707623761149, zoom: 15)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = self
        
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "night_mode", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        
        
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
    }
    
    public func addBottomSheetView() {
        addPullUpController(pullUpController, initialStickyPointOffset: 100, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheetView()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
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
