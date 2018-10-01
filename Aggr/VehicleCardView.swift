//
//  VehicleCardView.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/26/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//


// NOW USING A CARD AND CARD DECK SCHEMA!
import UIKit


enum CardPosition {
    case left
    case center
    case right
}


class VehicleCardView: UIView {
    
    var position: CardPosition
    
    
    
    override init(frame: CGRect) {
        //TODO: 
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func changePosition(to: CardPosition) {
        // TODO:
    }
    
    
    
    var textMultiplyer : CGFloat{ //Everything else can be a multiple of this text size
        switch position {
        case CardPosition.center:
            return 1
        default:
            return 0.8 // TODO: Change this to a way to mess w it, make it match, maybe distance to screen
        }
    }
    
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
