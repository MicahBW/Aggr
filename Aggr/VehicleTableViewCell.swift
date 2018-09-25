//
//  VehicleTableViewCell.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/22/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    // TODO:
    
    
    init(providingCompany : Company, style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure(providingCompany: providingCompany)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(providingCompany : Company) {
        imgView.image = logoForCompany(providingCompany)
        imgView.makeCircular()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}



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
/*
func createVehicleTableViewCellFrom(vehicle: Vehicle) ->
*/
