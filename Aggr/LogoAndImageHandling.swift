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
