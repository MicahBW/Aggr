//
//  LogoAndImageHandling.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/26/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import UIKit



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


func logoForVehicleType(_ type: VehicleType) -> UIImage {
    
    
    var returnImg : UIImage
    switch type {
    case VehicleType.bike:
        returnImg = UIImage(named: "BikeMarker")!
    case VehicleType.scooter:
        returnImg = UIImage(named: "ScooterMarker")!
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
