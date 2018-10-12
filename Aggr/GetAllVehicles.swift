//
//  GetAllVehicles.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 10/3/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import CoreLocation


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







/// Takes an array of vehicles and sorts them by distance from the user, with the closest being first and the furthest being last.
///
/// - Parameter vehicles: An array of unsorted vehicles
/// - Returns: An array of vehicles sorted from closest (first) to furthest
func sortVehiclesByDistance(_ vehicles : [Vehicle]) -> [Vehicle] {
    var sorted : [Vehicle]
    //IDEA: Add boolean input value to determine the direction of sorting and traversal
    // Make certain that vehicles array is not empty
    if vehicles.count == 0 { return [] }
    
    for vehicle in vehicles {
        var hasBeenInserted : Bool = false;
        var counter : Int = 0
        for compareTo in sorted {
            if vehicle.distanceFromUser < compareTo.distanceFromUser { // If the distance is less than the current `distance found on the transversal
                sorted.insert(vehicle, at: counter)
                hasBeenInserted = true
                break
            }
            counter += 1;
        }
        // In the case that it has made it through the entire array without being smaller than anything
        if !hasBeenInserted {
            sorted.append(vehicle)
        }
    }
    
}
