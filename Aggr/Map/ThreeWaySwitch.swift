//
//  ThreeWayButton.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 12/5/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//


import UIKit




class ThreeWaySwitch : UIControl {
    
    
    /*       DEFAULT BEHAVIOR IS AS FOLLOWS:
     *
     *  Move to the point that has been touched.
     *
     */
    
    
    
    //MARK: - Variables
    public var slideTime : TimeInterval = 1;
    public var testing : Bool = true
    private var selectorBoundries : CGFloat = 1;
    public var leftView : UIImageView = UIImageView()
    public var middleView : UIImageView = UIImageView()
    public var rightView : UIImageView = UIImageView()
    public var selectorView : UIImageView = UIImageView()
    private var currentSelectorPosition : Position = Position.Middle {
        willSet(newSelectorPosition) {
            runWillGoUserDefinedAction(forNewPosition: newSelectorPosition)
            print("About to set totalSteps to \(newSelectorPosition)")
        }
        didSet {
            changePosition(to: currentSelectorPosition);
            runDidGoUserDefinedAction(forNewPosition: currentSelectorPosition)
        }
    }
    
    
    /// Provides an easy way to change the background color of all three sections
    public var backColor : UIColor = .white {
        didSet {
            leftView.backgroundColor = backColor
            middleView.backgroundColor = backColor
            rightView.backgroundColor = backColor
        }
    }
    
    
    /// Provides an easy way to change the background color of the selector
    public var selectorColor : UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            selectorView.backgroundColor = selectorColor
        }
    }
    //TODO: Add functionality like currentSelectorPosition but for setting ang getting shadows and stuff
    
    
    //MARK: - User Actions
    public var willGoLeftAction : () -> Void = {return;}
    public var didGoLeftAction : () -> Void = {return;}
    public var willGoMiddleAction : () -> Void = {return;}
    public var didGoMiddleAction : () -> Void = {return;}
    public var willGoRightAction : () -> Void = {return;}
    public var didGoRightAction : () -> Void = {return;}
    
    
    //MARK: - Position
    enum Position {
        case Left
        case Middle
        case Right
    }
    
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        
        // Get the width and the height of the TWS
        let entireSwitchWidth = frame.width
        let entireSwitchHeight = frame.height
        
        // Set the positions / frames of the components
        leftView.frame = CGRect(x: 0, y: 0, width: entireSwitchWidth/3, height: entireSwitchHeight)
        middleView.frame = CGRect(x: (1/3) * entireSwitchWidth, y: 0, width: entireSwitchWidth/3, height: entireSwitchHeight)
        rightView.frame = CGRect(x: (2/3) * entireSwitchWidth, y: 0, width: entireSwitchWidth/3, height: entireSwitchHeight)
        selectorView.frame = CGRect(x: (1/3) * entireSwitchWidth + selectorBoundries, y: selectorBoundries, width: entireSwitchWidth/3 - (2*selectorBoundries), height: entireSwitchHeight - (2*selectorBoundries))
        
        
        // Set the background colors for testing
        leftView.backgroundColor = backColor
        middleView.backgroundColor = backColor
        rightView.backgroundColor = backColor
        selectorView.backgroundColor = selectorColor
        
        
        // Dealing with rounding corners
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        
        
        // Add shadow to the selector
        selectorView.layer.shadowColor = UIColor.black.cgColor
        selectorView.layer.shadowOpacity = 0.8
        selectorView.layer.shadowOffset = CGSize(width: 4, height: 4)
        selectorView.layer.shadowRadius = 10
        
        
        // Add inset shadow
        
        // Add all of the components as subviews
        addSubview(leftView)
        addSubview(middleView)
        addSubview(rightView)
        addSubview(selectorView)
        
        
        
        // Make sure that the selector is on top
        self.bringSubview(toFront: selectorView)
        
        // Round the corners of the selector view
        selectorView.layer.cornerRadius = 5
        selectorView.layer.masksToBounds = false
        
        // Allow the components to be Interactive (Required for Tap Recognition)
        leftView.isUserInteractionEnabled = true
        middleView.isUserInteractionEnabled = true
        rightView.isUserInteractionEnabled = true
        
        // Listen for touches up inside (a user has clicked one of the three positions)
        let leftTap = UITapGestureRecognizer(target: self, action:  #selector (self.goToLeft (_:)))
        let middleTap = UITapGestureRecognizer(target: self, action:  #selector (self.goToMiddle (_:)))
        let rightTap = UITapGestureRecognizer(target: self, action:  #selector (self.goToRight (_:)))
        
        leftView.addGestureRecognizer(leftTap)
        middleView.addGestureRecognizer(middleTap)
        rightView.addGestureRecognizer(rightTap)
        
    }
    
    
    
    //MARK: - Gesture Listeners For Taps
    
    @objc func goToLeft(_ sender:UITapGestureRecognizer){
        if testing { print("go to left") }
        currentSelectorPosition = Position.Left
    }
    @objc func goToMiddle(_ sender:UITapGestureRecognizer){
        if testing { print("go to middle") }
        currentSelectorPosition = Position.Middle
    }
    @objc func goToRight(_ sender:UITapGestureRecognizer){
        if testing { print("go to right") }
        currentSelectorPosition = Position.Right
    }
    
    
    
    // MARK: - Sliding Functionality
    
    private func changePosition(to newPosition:Position) -> Void {
        //let slideDistance : CGFloat = frame.width / 3
        let prevWidth = selectorView.frame.width;
        let prevHeight = selectorView.frame.height
        UIView.animate(withDuration: slideTime, animations: {
            self.selectorView.frame = CGRect(x: self.selectorOrigin(forPosition: newPosition).x, y: self.selectorOrigin(forPosition: newPosition).y, width: prevWidth, height: prevHeight)
        }, completion: nil)
        
    }
    
    private func selectorOrigin(forPosition position: Position) -> CGPoint {
        let entireSwitchWidth = frame.width
        switch position {
        case Position.Left:
            return CGPoint(x: selectorBoundries, y: selectorBoundries)
        case Position.Middle:
            return CGPoint(x: ( (1/3) * entireSwitchWidth ) + selectorBoundries, y: selectorBoundries)
        case Position.Right:
            return CGPoint(x: ( (2/3) * entireSwitchWidth ) + selectorBoundries, y: selectorBoundries)
        }
        
    }
    
    
    
    private func runWillGoUserDefinedAction(forNewPosition position: Position) {
        switch position {
        case Position.Left:
            return willGoLeftAction()
        case Position.Middle:
            return willGoMiddleAction()
        case Position.Right:
            return willGoRightAction()
        }
    }
    
    private func runDidGoUserDefinedAction(forNewPosition position: Position) {
        switch position {
        case Position.Left:
            return didGoLeftAction()
        case Position.Middle:
            return didGoMiddleAction()
        case Position.Right:
            return didGoRightAction()
        }
    }
    
    
    
}
