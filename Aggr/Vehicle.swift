//
//  Vehicle.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/13/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import GoogleMaps

/// A class representing a vehicle, complete with location, the owning company, the type of vehicle, and the scooterData if it is a scooter
class Vehicle: Equatable, Hashable {
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.location.latitude == rhs.location.latitude && lhs.location.longitude == rhs.location.longitude
    }
    
    
    var location: CLLocationCoordinate2D
    var company: Company
    var type: VehicleType
    var scooterInfo: ScooterData?
    var distance: CLLocationDistance = 0
    
    /// Standard initializer to be used when called by get functions
    ///
    /// - Parameters:
    ///   - location: The location where the vehicle is parked
    ///   - owner: The owning company (i.e. limeBike or ofo)
    ///   - type: The type of vehicle that it is (i.e. bike or scooter)
    ///   - scooterInfo: An optional variable used to transfer scooter-exclusive data that does not apply to non-battery-operated vehicles such as bikes
    init (location: CLLocationCoordinate2D, company: Company, type: VehicleType, scooterInfo: ScooterData?) {
        self.location = location
        self.company = company
        self.type = type
        self.scooterInfo = scooterInfo
        self.distance = 0.0
    }
    
    var hashValue: Int {
        get {
            return Int(location.latitude * 100 + location.longitude * 100);
        }
    }
    
    var distanceFromUser : CLLocationDistance {
        return self.distance
    }

}
