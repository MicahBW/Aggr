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
        let rand : [Float] = [0.1,0.2,0.3,0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3]
        
        let randChoice = rand.randomElement()
        self.distance = CLLocationDistance(randChoice!)
        
    }
    
    /*
     var tableViewCell : VehicleTableViewCell {
     return VehicleTableViewCell(providingCompany: self.owner, style: UITableViewCellStyle.default, reuseIdentifier: nil)
     }
     */
    
    var hashValue: Int {
        get {
            return Int(location.latitude * 100 + location.longitude * 100);
        }
    }
    
    // TODO: Function to make a marker.
    
    
    
    var distanceFromUser : CLLocationDistance {
        let userloc = CLLocation()
        //return userloc.distance(from: CLLocation(latitude: location.latitude, longitude: location.longitude))
        /*let rand : [Float] = [0.1,0.2,0.3,0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2, 1.3]
        
        let randChoice = rand.randomElement()
        return CLLocationDistance(randChoice!)*/
        
        return self.distance
    }
    
    
    //func isCloserThan()
    
    
}
