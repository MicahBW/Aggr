//
//  VehicleMarker.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/13/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreLocation
import UIKit

// Reference: https://developers.google.com/maps/documentation/android-sdk/marker

// Reference: https://developers.google.com/maps/documentation/ios-sdk/reference/interface_g_m_s_marker


struct VehicleMarkerStyle {
    var icon : UIImage
    var color : UIColor = .black
    
    
    init (forCompany company: Company, andVehicleType vehicleType: VehicleType) {
        icon = pinForVehicleTypeAndCompany(type: vehicleType, company: company)
    }
}

class VehicleMarker : GMSMarker {
    
    var vehicle : Vehicle
    
    
    init (forVehicle vehicle: Vehicle) {
        
        self.vehicle = vehicle
        
        super.init()
        self.isDraggable = false
        self.tracksInfoWindowChanges = true
        self.tracksViewChanges = true
        
        
        // Add vehicle-specific info
        
        self.position = self.vehicle.location
        self.icon = markerIcon
        
        self.title = nameOfCompany( self.vehicle.company)
        var vehType = ""
        switch(self.vehicle.type) {
        case VehicleType.bike:
            vehType = "Bike"
        case VehicleType.scooter:
            // Add this line when battery is available vehType = "Scooter\nBattery Level: " + String(vehicle.scooterInfo!.batteryCharge) + "%"
            vehType = "Scooter\nBattery Level: Unknown"
        default:
            vehType = "Bike"
        }
        let snip = "Type: " + vehType
        self.snippet = snip
    }
    
    
    var markerIcon : UIImage {
        let retIcon = pinForVehicleTypeAndCompany(type: vehicle.type, company: vehicle.company)
        return retIcon;
    }
    
    
    
    
}
