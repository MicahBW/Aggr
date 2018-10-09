//
//  GetAllVehicles.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 10/3/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation


func getAllVehicles(withinRange range: CLLocationDistance, ofLocation location: CLLocationCoordinate2D) -> [Vehicle] {
    
    var aggregateVehiclesList : [Vehicle]
    
    // Add all of the vehicles to the list
    if ( Constants.GettingVehicles.companyIsEnabled(company: Company.bird) ) {
        if let birdList : [Vehicle] = getBirdVehicles(withinRange: range, ofLocation: location) {
            aggregateVehiclesList.append(contentsOf: birdList)
        }
    }
    
    //TODO: OFO
    
    //TODO: LIMEBIKE
    
    
    // Reorganize by closest to furthest
    
    
}



func sortVehiclesByDistance(_ vehicles : [Vehicle]) -> [Vehicle] {
    var sorted : [Vehicle]
    
    if let vehicles[0] = FIRST_EXCEPTION\
    
    //TODO: TMRW
}
