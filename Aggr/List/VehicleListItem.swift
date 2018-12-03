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
    let dtvWidth : CGFloat = 150

    var companyButton : UIButton
    var distanceTextView: UITextView
    var directionsButton: UIButton
    var typeIconImageView: UIImageView
    
    var lastVehicleUpdatedToShow : Vehicle? = nil
    
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
        lastVehicleUpdatedToShow = vehicle
        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.layer.cornerRadius = self.frame.height/2
        
        // company button
        addSubview(companyButton)
        //companyButton.backgroundColor = UIColor(white: 0, alpha: 0.7)
        companyButton.frame = CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height)
        companyButton.setImage(logoForCompany(vehicle.company), for: .normal)
        companyButton.layer.cornerRadius = self.frame.height/2
        companyButton.imageView?.contentMode = .scaleAspectFit
        companyButton.imageEdgeInsets = UIEdgeInsetsMake(5.0, 0.0, 5.0, 0.0)
        
        // distanceTextView
        addSubview(distanceTextView)
        distanceTextView.isSelectable = false
        distanceTextView.isEditable = false
        distanceTextView.backgroundColor = .clear
        distanceTextView.isScrollEnabled = false
        distanceTextView.frame = CGRect(x: self.frame.height + 2 * margins, y: margins, width: dtvWidth, height: dtvHeight)
        if (vehicle.company == Company.bird){
        distanceTextView.text = String(vehicle.distanceFromUser.truncate(places: 1)) + " mi " + "$1+0.15/min"
        } else if (vehicle.company == Company.jump) {
            distanceTextView.text = String(vehicle.distanceFromUser.truncate(places: 1)) + " mi " + "$4/hr"
        } else {
            if (vehicle.type == VehicleType.bike) {
                distanceTextView.text = String(vehicle.distanceFromUser.truncate(places: 1)) + " mi " + "$2/hr"
            } else {
                distanceTextView.text = String(vehicle.distanceFromUser.truncate(places: 1)) + " mi " + "$1+0.15/min"
            }
        }
        distanceTextView.font = UIFont(name: "Copperplate-Bold", size: 14)
        distanceTextView.textColor = .white
        
        
        
        // directions button
        addSubview(directionsButton)
        //directionsButton.backgroundColor = .yellow
        directionsButton.frame = CGRect(x: self.frame.width - self.frame.height - self.margins - (Constants.VehicleList.itemHeight - 2 * Constants.VehicleList.spacing), y: self.margins, width: Constants.VehicleList.itemHeight - 2 * Constants.VehicleList.spacing , height: Constants.VehicleList.itemHeight - 2 * Constants.VehicleList.spacing)
        directionsButton.setImage(UIImage(named: "DirectionsIcon"), for: .normal)
        
        // typeIconImageView
        addSubview(typeIconImageView)
        typeIconImageView.backgroundColor = .orange
        typeIconImageView.frame = CGRect(x: self.frame.width - self.frame.height, y: 0, width: self.frame.height, height: self.frame.height)
        typeIconImageView.layer.cornerRadius = self.frame.height/2
        typeIconImageView.image = imageForVehicleType(vehicle.type)
        directionsButton.addTarget(self, action: #selector(directionsButtonPressed), for: .touchUpInside)
        companyButton.addTarget(self, action: #selector(companyButtonPressed), for: .touchUpInside)
    
    }
    
    
    /// Must be called after it has been added to a superview that also has a superview
    ///
    /// - Returns: Void
    public func centerInView () -> Void {
        if let superv = self.superview, let supersuperv = self.superview?.superview {
            self.center = superv.convert(superv.center, from:supersuperv)
        }
    }
    
    @objc private func directionsButtonPressed (sender: UIButton!) -> Void {
        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(lastVehicleUpdatedToShow!.location.latitude),\(lastVehicleUpdatedToShow!.location.longitude)&directionsmode=walking") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @objc private func companyButtonPressed (sender: UIButton!) -> Void {
        switch lastVehicleUpdatedToShow!.company {
        case .bird:
            UIApplication.shared.openURL(URL(string: "bird://")!)
        case .limeBike:
            UIApplication.shared.openURL(URL(string: "limebike://")!)
        case .jump:
            UIApplication.shared.openURL(URL(string: "jump://")!)
        default:
            print("Error: Company Button Does Not Exist")
        }
    }
    
}

