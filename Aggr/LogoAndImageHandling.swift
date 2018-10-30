//
//  LogoAndImageHandling.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/26/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


//MARK: - Extend UIImageView
extension UIImageView {
    
    func makeCircular() -> Void {
        self.layer.cornerRadius = self.frame.height/2
    }
    
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    
}

/*
extension UIView {
    
    // If Swift version is lower than 4.2,
    // You should change the name. (ex. var renderedImage: UIImage?)
    
    var snapImage: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
    }
}
*/

extension UIImage
{
    
    
    
    /*
    func tinted(color: UIColor) -> UIImage {
        
        let imgView = UIImageView(image: self)
        let templateImage = imgView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        imgView.image = templateImage
        imgView.tintColor = color
        
        //return imgView.snapImage!
        
        
    }
 */
    
    
    
    
    
    
}



func logoForCompany(_ company : Company) -> UIImage {
    var companyLogo : UIImage
    //TODO: Guard them!
    switch company {
    case Company.bird:
        companyLogo = #imageLiteral(resourceName: "BirdIcon")
    case Company.limeBike:
        companyLogo = #imageLiteral(resourceName: "LimeBikeIcon")
    default:
        companyLogo = #imageLiteral(resourceName: "UnkIcon")
    }
    
    return companyLogo
}


func colorForCompany(_ company: Company) -> UIColor {
    var col: UIColor
    switch company {
    case Company.bird:
        col = .white
    case Company.limeBike:
        col = .green
    default:
        col = .red
    }
    
    return col
}


func logoForVehicleTypeAndCompany(type: VehicleType, company: Company) -> UIImage {
    
    
    var returnImg : UIImage
    switch type {
    case VehicleType.bike:
        returnImg = UIImage(named: "LimeBikeMarker")!
    case VehicleType.scooter:
        if company == Company.bird {
            returnImg = UIImage(named: "BirdScooterMarker")!
        } else {
            returnImg = UIImage(named: "LimeScooterMarker")!
        }
    default:
        returnImg = UIImage(named: "BikeMarker")!
    }
    
    return imageWithImage(image: returnImg, scaledToSize: Constants.ImageHandling.Markers.markerSize)
}



// TODO: Rename
func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
}




func nameOfVehicleType(_ type: VehicleType) -> String {
    switch type {
    case VehicleType.bike:
        return "Bike"
    case VehicleType.scooter:
        return "Scooter"
    default:
        return "Unknown"
    }
}


func nameOfCompany(_ company: Company) -> String {
    switch company {
    case Company.bird:
        return "Bird";
    case Company.ofo:
        return "Ofo";
    case Company.limeBike:
        return "Lime";
    default:
        return "Unknown";
    }
}


extension CLLocationDistance {
    var inMiles : Float {
        return  Float(self)/1609.344
    }
}
