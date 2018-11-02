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

//https://developers.google.com/maps/documentation/android-sdk/marker

//https://developers.google.com/maps/documentation/ios-sdk/reference/interface_g_m_s_marker


struct VehicleMarkerStyle {
    var icon : UIImage
    var color : UIColor = .black
    
    
    init (forCompany company: Company, andVehicleType vehicleType: VehicleType) {
        icon = pinForVehicleTypeAndCompany(type: vehicleType, company: company)
        //color = colorForCompany(company)
    }
    /*
    init (forVehicle vehicle: Vehicle) {
        icon = logoForVehicleTypeAndCompany(type: vehicle.type, company: company)
        //color = colorForCompany(vehicle.company)
    }
 */
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
        //self.icon = VehicleMarkerStyle(forVehicle: self.vehicle).icon
        self.icon = markerIcon

        
        
    }
    
    
    var markerIcon : UIImage {
        let retIcon = pinForVehicleTypeAndCompany(type: vehicle.type, company: vehicle.company)
        //retIcon.tint(color: UIColor.yellow)s
        //UIImageView.tintColor = UIColor.yellow
        //let myimage = retIcon.withRenderingMode(.alwaysTemplate)
        //return retIcon.tint(color: UIColor.yellow)
        //return retIcon.tinted(color: UIColor.purple)
        return retIcon;
    }
    
    
    
    
}
