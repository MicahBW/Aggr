//
//  VerticleLayout.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 11/2/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import UIKit

class VerticalLayout: UIView {
    
    var yOffsets: [CGFloat] = []
    
    init(width: CGFloat) {
        super.init(frame: CGRect(x: 0,y: 0, width: width, height: 0))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        var height: CGFloat = 0
        
        for i in 0..<subviews.count {
            let view = subviews[i] as UIView
            view.layoutSubviews()
            height += yOffsets[i]
            view.frame.origin.y = height
            height += view.frame.height
        }
        
        self.frame.size.height = height
        
    }
    
    override func addSubview(_ view: UIView) {
        
        yOffsets.append(view.frame.origin.y)
        super.addSubview(view)
        
    }
    
    func removeAll() {
        
        for view in subviews {
            view.removeFromSuperview()
        }
        yOffsets.removeAll(keepingCapacity: false)
        
    }
    
}



/// A verticle layout which always takes the width of the screen
/// Height is placed relative to one abbove it
class VerticalScreenLayout: VerticalLayout {
    
    
    init() {
        super.init(width: UIScreen.main.bounds.width)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.frame.size.width = UIScreen.main.bounds.width
        super.layoutSubviews()
        
    }
    
}





