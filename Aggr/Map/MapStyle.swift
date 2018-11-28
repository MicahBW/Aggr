//
//  MapStyle.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 11/28/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces


public enum MapStyleModes {
    case Day
    case Night
    case Christmas
}


extension GMSMapView {
    
    public func StylizeForStyleMode(mode: MapStyleModes) {
        let resource : String = Constants.MapStyles.filename(forMapStyle: mode)
        self.StylizeWithJSONFile(Bundle.main.url(forResource: resource, withExtension: "json"))
    }
    private func StylizeWithJSONFile(_ url : URL?) {
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = url {
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Invalid URL passed to StylizeWithJSONFile")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
}
