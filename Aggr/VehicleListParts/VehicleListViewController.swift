//
//  VehicleListViewController.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 11/1/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//


//https://medium.com/swift-programming/dynamic-layouts-in-swift-b56cf8049b08

import UIKit
import CoreLocation
import CoreData



class VehicleListViewController: PullUpController {
    
    
    var vertView : VerticalScreenLayout
    
    
    
    
    init() {
        vertView = VerticalScreenLayout()
        super.init(nibName: nil, bundle: nil)
        view.addSubview(vertView) // vertView is a subview of View!
        //view.backgroundColor = UIColor(white: 0, alpha: 0.5) // Do only if it is up
    }
    
    
    
    
    /// Required initializer: fails with message "init(coder:) has not been implemented": Fatal Error
    ///
    /// - Parameter aDecoder:
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    public func updateList(withVehicles vehicles: [Vehicle]) -> Void {
        
        for vehicle in vehicles {
            
            //let listItem : VehicleListItemView = VehicleListItemView(frame: vertLayout.frame) //FIX
            
           // listItem.configure(forVehicle: vehicle)
            
            //vertLayout.addSubview(VehicleListItemView())
            
        }
    }
    
    
    
    public func addItemForVehicle(_ vehicle: Vehicle) {
        var item = VehicleListItem(frame: CGRect(x: 0, y: Constants.VehicleList.spacing, width: Constants.VehicleList.itemWidth, height: Constants.VehicleList.itemHeight))
        item.configure(forVehicle: vehicle)
        vertView.addSubview(item)
    }
    
}






/*
class VehicleListViewController: UIViewController {
    
    
    /*
    
    var vertLayout : VerticalLayout
    
    init () {
        vertLayout = VerticalLayout(width: 343) //PERROR:
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    */
    
    /// Called when the viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add pan gesture recognizer
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(VehicleListViewController.panGesture))
        view.addGestureRecognizer(gesture)
        
      //  self.view.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
    }
    
    
    /// Called when view will appear.  Use to call prepareBackgroundView
    ///
    /// - Parameter animated: Animated
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    
    
    /// Called after the view appears for the first time.
    ///
    /// - Parameter animated: Animated
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }

    
    
    /// Pan gesture: when it goes up.
    ///
    /// - Parameter recognizer: Recognizer
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        print(" \n PAN PAN PAN \n")
        let translation = recognizer.translation(in: self.view)
        let y = self.view.frame.minY
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint(), in: self.view)
    }
    
    
    
    /// Used to prepare the background of the view
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let blurredView = UIVisualEffectView.init(effect: blurEffect)
        blurredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        blurredView.frame = UIScreen.main.bounds
        
        view.insertSubview(blurredView, at: 0)
        
    }
    
    
    
    /*
    func updateList(withVehicles vehicles: [Vehicle]) -> Void {
        
        //PERROR: Doing some sketch ass shit down here
        
        
        
        for vehicle in vehicles {
            
            let listItem : VehicleListItemView = VehicleListItemView(frame: vertLayout.frame) //FIX
            
            listItem.configure(forVehicle: vehicle)
            
            vertLayout.addSubview(VehicleListItemView())
            
        }
        
    }
 */
    
    
    /*
 companyButton.setImage(logoForCompany(vehicle.company), for: .normal)
 directionsButton.setImage(UIImage(named: "DirectionsIcon"), for: .normal)
 distanceTextView.text = String(vehicle.distanceFromUser) + " mi"
 }*/
    
    
    
    
    
    
    

}
*/
/*

class VehicleListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(VehicleListViewController.panGesture))
        view.addGestureRecognizer(gesture)
        
    }
    
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            let frame = self?.view.frame
            let yComponent = UIScreen.main.bounds.height - 200
            self?.view.frame = CGRect(x: 0, y: yComponent, width: frame!.width, height: frame!.height)
        }
    }
    
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let y = self.view.frame.minY
        self.view.frame = CGRect(x: 0, y:  y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(.zero, in: self.view)
    }
    /*
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        
        let y = view.frame.minY
        if (y == fullView && tableView.contentOffset.y == 0 && direction > 0) || (y == partialView) {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
        
        return false
    }
 */



}

*/
