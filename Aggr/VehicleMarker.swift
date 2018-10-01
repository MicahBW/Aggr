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

//https://developers.google.com/maps/documentation/android-sdk/marker

//https://developers.google.com/maps/documentation/ios-sdk/reference/interface_g_m_s_marker


struct VehicleMarkerStyle {
    var icon : UIImage
    var color : UIColor
    
    
    init (forCompany company: Company, andVehicleType vehicleType: VehicleType) {
        icon = logoForVehicleType(vehicleType)
        color = colorForCompany(company)
    }
    
    init (forVehicle vehicle: Vehicle) {
        icon = logoForVehicleType(vehicle.type)
        color = colorForCompany(vehicle.owner)
    }
}





class VehicleMarker : GMSMarker {
    
    var vehicle : Vehicle
    
    //vehicleType : VehicleType
    //init (position markerPosition: CLLocationCoordinate2D, styleInfo: VehicleMarkerStyle, title markerTitle: String? = nil, snippet markerSnippet: String? = nil) {
    init (forVehicle vehicle: Vehicle) {
        
        self.vehicle = vehicle
        
        super.init()
        self.isDraggable = false
        self.tracksInfoWindowChanges = true
        self.tracksViewChanges = true
        
        
        
        //self.icon = GMSMarker.markerImage(with: <#T##UIColor?#>)
        
        // Add vehicle-specific info
        
        self.position = self.vehicle.location
        self.icon = VehicleMarkerStyle(forVehicle: self.vehicle).icon

        
        
    }
    
    
    
    
}
