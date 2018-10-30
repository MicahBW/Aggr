//
//  Constants.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 10/1/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import CoreData
import CoreLocation


struct Constants {
    
    public static let distanceFromCenter = 0.0002
    
    struct UIColorCollection {
        public static let shyMoment = UIColor(red: 162, green: 155, blue: 254, alpha: 1.0);
    }
    
    
    struct GMSHandling {
        
        public static let APIKey = "AIzaSyCeyTRCibAy4ax2biVBzO76yeQZWPA3ULw"
        
    }
    
    struct MapTesting {
        
        struct TestCoordinates {
            
            public static let tc1 = CLLocationCoordinate2DMake(38.898366, -77.039474)
            
            public static let tc2 = CLLocationCoordinate2DMake(38.900321, -77.033644)
            
            public static let tc3 = CLLocationCoordinate2DMake(38.900000, -77.033634)
            
            public static let tc4 = CLLocationCoordinate2DMake(38.899999, -77.033635)
            
            public static let tc5 = CLLocationCoordinate2DMake(38.899988, -77.033600)
            
            public static let userTestPos = CLLocationCoordinate2DMake(38.90000, -77.0336)

        }
        
    }
    
    struct ImageHandling {
        
        struct Markers {
        
            private static let heightToWidthMarkerRatio : CGFloat =  (2048/1447)  // beware of typecasting the other one as an int!!!!
            
            private static let markerWidth : CGFloat = 45

            public static let markerSize : CGSize = CGSize(width: markerWidth, height: heightToWidthMarkerRatio * markerWidth)
            
        }
    }
    
    struct GettingVehicles {
        
        public static func companyIsEnabled(company: Company) -> Bool {
            switch company {
            case Company.bird:
                return false
            case Company.limeBike:
                return false
            case Company.ofo:
                return false
            default:
                return false
            }
        }
    }
    
    
    
    
}
