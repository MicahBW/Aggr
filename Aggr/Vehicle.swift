//
//  Vehicle.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/13/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import CoreLocation


/// A class representing a vehicle, complete with location, the owning company, the type of vehicle, and the scooterData if it is a scooter
class Vehicle {

    var location: CLLocationCoordinate2D
    var owner: Company
    var type: VehicleType
    var scooterInfo: ScooterData?
    
    
    /// Standard initializer to be used when called by get functions
    ///
    /// - Parameters:
    ///   - location: The location where the vehicle is parked
    ///   - owner: The owning company (i.e. limeBike or ofo)
    ///   - type: The type of vehicle that it is (i.e. bike or scooter)
    ///   - scooterInfo: An optional variable used to transfer scooter-exclusive data that does not apply to non-battery-operated vehicles such as bikes
    init (location: CLLocationCoordinate2D, owner: Company, type: VehicleType, scooterInfo: ScooterData?) {
        self.location = location
        self.owner = owner
        self.type = type
        self.scooterInfo = scooterInfo
    }
    
    
    // TODO: Function to make a marker.
    
    
}
