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

class VehicleMarker : GMSMarker {
    
    var vehicleType : VehicleType
    
    init (position markerPosition: CLLocationCoordinate2D, vehicleType: VehicleType, title markerTitle: String? = nil, snippet markerSnippet: String? = nil) {
        
        self.vehicleType = vehicleType
        
        super.init() //PERROR:
        
        self.position = markerPosition
        self.tracksInfoWindowChanges = true
        self.tracksViewChanges = true
        
        
        
        
    }
    
    
    
    
}
