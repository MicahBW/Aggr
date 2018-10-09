//
//  Constants.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 10/1/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import CoreGraphics


struct Constants {
    
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
