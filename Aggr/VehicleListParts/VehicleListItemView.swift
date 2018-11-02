//
//  VehicleListItemView.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 11/1/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import UIKit

class VehicleListItemView: UIView {
    
    let margins : CGFloat = 9
    
    var companyButton : CompanyButton
    var distanceTextView: DistanceTextView
    var directionsButton: DirectionsButton
    var typeIconImageView: TypeIconImageView
    
    override init(frame: CGRect) {
        companyButton = CompanyButton()
        distanceTextView = DistanceTextView()
        directionsButton = DirectionsButton()
        typeIconImageView = TypeIconImageView()
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        companyButton = CompanyButton()
        distanceTextView = DistanceTextView()
        directionsButton = DirectionsButton()
        typeIconImageView = TypeIconImageView()
        super.init(coder: aDecoder)
        print("Vehicle List Item View RQUIRED CODER USED -- THIS SHOULD NOT HAPPEN")
    }
    
    
    /// DO NOT CALL FROM INIT
    ///
    /// - Parameter vehicle: Vehicle passed in
    public func configure(forVehicle vehicle : Vehicle) {
        
        
       
        
        addSubview(companyButton)
        addSubview(distanceTextView)
        addSubview(directionsButton)
        addSubview(typeIconImageView)
        
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    

}
