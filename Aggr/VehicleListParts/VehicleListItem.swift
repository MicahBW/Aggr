//
//  VehicleListItemView.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 11/1/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import UIKit

class VehicleListItem: UIView {
    
    
    let margins : CGFloat = 9
    let dtvHeight : CGFloat = 27
    let dtvWidth : CGFloat = 108

    
    
    var companyButton : UIButton
    var distanceTextView: UITextView
    var directionsButton: UIButton
    var typeIconImageView: UIImageView
    
    
    override init(frame: CGRect) {
        companyButton = UIButton()
        distanceTextView = UITextView()
        directionsButton = UIButton()
        typeIconImageView = UIImageView()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(forVehicle vehicle: Vehicle) {
        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.layer.cornerRadius = self.frame.height/2
        
        // company button
        addSubview(companyButton)
        companyButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
        companyButton.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
        companyButton.setImage(logoForCompany(vehicle.company), for: .normal)
        companyButton.layer.cornerRadius = self.frame.height/2
        
        
        // distanceTextView
        addSubview(distanceTextView)
        distanceTextView.isSelectable = false
        distanceTextView.isEditable = false
        //distanceTextView.backgroundColor = .green
        distanceTextView.frame = CGRect(x: self.frame.height + 2 * margins, y: margins, width: dtvWidth, height: dtvHeight)
        distanceTextView.text = String(vehicle.distanceFromUser.truncate(places: 1)) + " mi"
        
        
        // directions button
        addSubview(directionsButton)
        directionsButton.backgroundColor = .yellow
        directionsButton.frame = CGRect(x: self.frame.width - self.frame.height - self.margins - (Constants.VehicleList.itemHeight - 2 * Constants.VehicleList.spacing), y: self.margins, width: Constants.VehicleList.itemHeight - 2 * Constants.VehicleList.spacing , height: Constants.VehicleList.itemHeight - 2 * Constants.VehicleList.spacing)
        
        // typeIconImageView
        addSubview(typeIconImageView)
        typeIconImageView.backgroundColor = .orange
        typeIconImageView.frame = CGRect(x: self.frame.width - self.frame.height, y: 0, width: self.frame.height, height: self.frame.height)

    
    }
    
    
    /// Must be called after it has been added to a superview that also has a superview
    ///
    /// - Returns: Void
    public func centerInView () -> Void {
        if let superv = self.superview, let supersuperv = self.superview?.superview {
            self.center = superv.convert(superv.center, from:supersuperv)
        }
    }
}


/*
 // Only override draw() if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 override func draw(_ rect: CGRect) {
 // Drawing code
 }
 */

