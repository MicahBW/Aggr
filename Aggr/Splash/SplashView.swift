//
//  SplashView.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 11/27/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import UIKit

class SplashView: UIView {
    
    
    var icon : UIImageView;
    var spinning : Bool = true;
    
    
    override init(frame: CGRect) {
        icon = UIImageView(image: #imageLiteral(resourceName: "SplashIcon"))

        
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    public func Setup() -> Void {
        
        self.backgroundColor = .blue
        /*
        let horizontalConstraint = NSLayoutConstraint(item: icon, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: icon, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: icon, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: Constants.Splash.iconHieght)
        let aspectRatioConstraint = NSLayoutConstraint(item: icon, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: icon, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        self.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, aspectRatioConstraint]) //PERROR
        */
        
        let swidth = UIScreen.main.bounds.width
        let sheight = UIScreen.main.bounds.height
        let dim = Constants.Splash.iconHieght
        let vertOffset = (sheight - dim)/2
        let horOffset = (swidth - dim)/2
        
        
        self.addSubview(icon)
        
        icon.frame = CGRect(x: horOffset, y: vertOffset, width: dim, height: dim)
        
        
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.35
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        icon.layer.add(rotation, forKey: "rotationAnimation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.icon.layer.removeAllAnimations()
        }
 
        /*
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut,
                       animations: { self.icon.transform = CGAffineTransform(rotationAngle: CGFloat( 2 * CGFloat.pi)) },
                       completion: { (succeed) -> Void in }
        )
        */
        
        //StartSpinning()
    }
    
    public func StartSpinning(_ s: Bool = true) -> Void {
        if !spinning { return; }
        
        //UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {self.StartSpinning()}, completion: {})
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.25
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        icon.layer.add(rotation, forKey: "rotationAnimation")
        // or use the spring one
        StartSpinning()
    }
    
    public func StopSpinning() -> Void {
        spinning = false
    }
    
    private func Spin( _ rotations: Int) -> Void {
    }

}
