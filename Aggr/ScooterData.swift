//
//  ScooterData.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/13/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import CoreLocation



/// A struct for transmitting scooter-exclusive data that does not apply to non-battery-operated vehicles such as bikes
struct ScooterData  {  
    var batteryCharge: Int?
    var range: CLLocationDistance?
    
    
    
    /// Initializer for ScooterData struct
    ///
    /// - Parameters:
    ///   - batterCharge: Value from (Int) 0 to (Int) 100 describing the battery charge of the scooter
    ///   - range: The range of the scooter based on the battery charge
    init(batteryCharge: Int?, range: CLLocationDistance?) {
        self.batteryCharge = batteryCharge
        self.range = range
    }
    
}
