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

func imageForVehicleType(_ type: VehicleType) -> UIImage {
    switch type {
    case .bike:
        return #imageLiteral(resourceName: "BikeIcon");
    case .scooter:
        return #imageLiteral(resourceName: "ScooterIcon");
    default:
        return #imageLiteral(resourceName: "BikeIcon");
    }
}



func logoForCompany(_ company : Company) -> UIImage {
    var companyLogo : UIImage
    //TODO: Guard them!
    switch company {
    case Company.bird:
        companyLogo = #imageLiteral(resourceName: "BirdIcon")
    case Company.limeBike:
        companyLogo = #imageLiteral(resourceName: "LimeBikeIcon")
    case Company.jump:
        companyLogo = #imageLiteral(resourceName: "JumpBikeIcon")
    default:
        companyLogo = #imageLiteral(resourceName: "LimeBikeIcon")
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
    case Company.jump:
        col = .red
    default:
        col = .blue
    }
    
    return col
}


func pinForVehicleTypeAndCompany(type: VehicleType, company: Company) -> UIImage {
    
    
    var returnImg : UIImage
    switch type {
    case VehicleType.bike:
        if company == Company.jump {
            returnImg = UIImage(named: "JumpBikeMarker")!
        } else {
            returnImg = UIImage(named: "LimeBikeMarker")!
        }
    case VehicleType.scooter:
        if company == Company.bird {
            returnImg = UIImage(named: "BirdScooterMarker")!
        } else {
            returnImg = UIImage(named: "LimeScooterMarker")!
        }
    default:
        returnImg = UIImage(named: "LimeBikeMarker")!
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
    case Company.jump:
        return "Jump";
    case Company.limeBike:
        return "Lime";
    }
}


extension CLLocationDistance {
    var inMiles : Float {
        return  Float(self)/1609.344
    }
}


extension CLLocationDistance
{
    func truncate(places : Int)-> CLLocationDistance
    {
        return CLLocationDistance(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
