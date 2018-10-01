//
//  AggrUITests.swift
//  AggrUITests
//
//  Created by Micah Byrne Wolfsohn on 9/11/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import XCTest
import CoreLocation

/*
 You can animate the addition of new markers to the map by setting the marker.appearAnimation property to kGMSMarkerAnimationPop.
 
*/

class AggrUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func addMarkerToMap() {
        var ve : Vehicle = Vehicle(location: CLLocationCoordinate2DMake(0, 0), owner: Company.bird, type: VehicleType.bike, scooterInfo: nil);
        
        var mark : VehicleMarker = VehicleMarker(forVehicle: ve)
    }
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
