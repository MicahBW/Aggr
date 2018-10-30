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


struct Constants {
    
    public static let distanceFromCenter = 0.0002
    
    struct UIColorCollection {
        public static let shyMoment = UIColor(red: 162, green: 155, blue: 254, alpha: 1.0);
    }
    
    
    struct GMSHandling {
        
        public static let APIKey = "AIzaSyCeyTRCibAy4ax2biVBzO76yeQZWPA3ULw"
        
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
