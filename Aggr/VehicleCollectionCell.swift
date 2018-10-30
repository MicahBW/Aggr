//
//  VehicleCollectionCell.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 10/23/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import UIKit

enum VehicleCollectionStatus {
    case up
    case down
}

class VehicleCollectionCell: UICollectionViewCell {
    
    let leftPortion:CGFloat = 0.66
    let topPortion:CGFloat = 0.50
    let rightPortion:CGFloat = 0.34
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var backGrad: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    
    
    
    
    
    private func setup( ) -> Void {
        
        self.frame.size.width = 100
        self.frame.size.height = 60
        
        self.backgroundColor = Constants.UIColorCollection.shyMoment
        
        makeBackGradGradient()
        
        positionLabels(forVehicleCollectionStatus: .down) //TODO: Change
        
        print("yup \n")
        
    }
    
    
    public func configureForVehicle(_ vehicle: Vehicle) {
        companyLabel.text = nameOfCompany(vehicle.company)
        typeLabel.text = nameOfVehicleType(vehicle.type)
        distanceLabel.text = "0.3mi"
        setup()
    }
    
    
    
    
    
    
    private func makeBackGradGradient( ) -> Void {
        backGrad.frame = self.frame
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = backGrad.layer.frame
        backGrad.layer.insertSublayer(gradient, at: 0)
    }
    
    
    private func positionLabels(forVehicleCollectionStatus vehicleCollectionStatus: VehicleCollectionStatus) -> Void {
        switch vehicleCollectionStatus {
        case VehicleCollectionStatus.down:
            companyLabel.translatesAutoresizingMaskIntoConstraints = false
            let companyLeadingConstraint = NSLayoutConstraint(item: companyLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 5)
            let companyTopConstraint = NSLayoutConstraint(item: companyLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 4)
            let companyWidthConstraint = NSLayoutConstraint(item: companyLabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.frame.width * leftPortion)
            let companyHeightConstraint = NSLayoutConstraint(item: companyLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.frame.width * topPortion)
            companyLabel.addConstraints([companyLeadingConstraint, companyTopConstraint, companyWidthConstraint, companyHeightConstraint])
            
            
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            let typeLeadingConstraint = NSLayoutConstraint(item: typeLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 5)
            let typeBottomConstraint = NSLayoutConstraint(item: typeLabel, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 4)
            let typeWidthConstraint = NSLayoutConstraint(item: typeLabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.frame.width * leftPortion)
            let typeHeightConstraint = NSLayoutConstraint(item: typeLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.frame.width * topPortion)
            typeLabel.addConstraints([typeLeadingConstraint, typeBottomConstraint, typeWidthConstraint, typeHeightConstraint])
            
            
            distanceLabel.translatesAutoresizingMaskIntoConstraints = false
            let distanceTrailingConstraint = NSLayoutConstraint(item: distanceLabel, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 5)
            let distanceTopConstraint = NSLayoutConstraint(item: distanceLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 4)
            let distanceWidthConstraint = NSLayoutConstraint(item: distanceLabel, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.frame.width * rightPortion)
            let distanceHeightConstraint = NSLayoutConstraint(item: distanceLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: self.frame.width * topPortion)
            distanceLabel.addConstraints([distanceTrailingConstraint, distanceTopConstraint, distanceWidthConstraint, distanceHeightConstraint])
            
        default:
            return
            //some code
        }
        
        
        
        
        companyLabel.textColor = UIColor.white
        typeLabel.textColor = UIColor.white
        distanceLabel.textColor = UIColor.white
        
        
    }
    
    
    
    
    
    
    
    private func switchVehicleCollectionStatus() {
        //TODO
        //call positionLabels
    }

}
