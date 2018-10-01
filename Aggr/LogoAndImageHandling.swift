//
//  LogoAndImageHandling.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/26/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import UIKit




extension UIImageView {
    func makeCircular() -> Void {
        self.layer.cornerRadius = self.frame.height/2
    }
}


func logoForCompany(_ company : Company) -> UIImage {
    var companyLogo : UIImage
    
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


func logoForVehicleType(_ type: VehicleType) -> UIImage {
    
    
    var returnImg : UIImage
    switch type {
    case VehicleType.bike:
        returnImg = UIImage(named: "BikeIcon")!
    case VehicleType.scooter:
        returnImg = UIImage(named: "ScooterIcon")!
    }
    
    return imageWithImage(image: returnImg, scaledToSize: Constants.ImageHandling.markerSize)
}



// TODO: Rename
func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
}
