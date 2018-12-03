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

    public func Setup() -> Void {
        
        self.backgroundColor = .blue
        
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
 
    }
    
    public func StartSpinning(_ s: Bool = true) -> Void {
        if !spinning { return; }
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
