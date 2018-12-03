//
//  VehicleListViewController.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 11/1/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

// Reference: https://medium.com/swift-programming/dynamic-layouts-in-swift-b56cf8049b08

import UIKit
import CoreLocation
import CoreData

class VehicleListViewController: PullUpController {
    
    var vertView : VerticalScreenLayout
    var stickyPointsList : [CGFloat]
    
    init() {
        vertView = VerticalScreenLayout()
        stickyPointsList = [CGFloat]()
        super.init(nibName: nil, bundle: nil)
        view.addSubview(vertView) // vertView is a subview of View!
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
    
    /// Required initializer: fails with message "init(coder:) has not been implemented": Fatal Error
    ///
    /// - Parameter aDecoder:
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func updateList(withVehicles vehicles: [Vehicle]) -> Void {
        stickyPointsList.removeAll()
        deleteAllListItems()
        addToList(newVehicles: vehicles)
    }
    
    public func addToList(newVehicles vehicles: [Vehicle]) -> Void {
        for vehicle in vehicles {
            addItemForVehicle(vehicle)
        }
    }
    
    public func deleteAllListItems() -> Void {
        for li in vertView.subviews {
            li.removeFromSuperview()
        }
    }
    
    
    public func removeListItem(_ item: VehicleListItem) -> Void {
        self.view.willRemoveSubview(item) // Possibly problematic not to mention sticky points
        // maybe instead just make a new instance of this object, just without any subviews!
    }
    
    public func addItemForVehicle(_ vehicle: Vehicle) -> Void {
        let item = VehicleListItem(frame: CGRect(x: 0, y: Constants.VehicleList.spacing, width: Constants.VehicleList.itemWidth, height: Constants.VehicleList.itemHeight))
        item.configure(forVehicle: vehicle)
        vertView.addSubview(item)
        item.centerInView()
        let numItems : Int = vertView.subviews.count
        let heightPerItem : CGFloat = Constants.VehicleList.spacing + Constants.VehicleList.itemHeight
        let totalHeight : CGFloat = CGFloat(numItems) * heightPerItem
        stickyPointsList.append(totalHeight)
    }
    
    override var pullUpControllerMiddleStickyPoints: [CGFloat] {
        return stickyPointsList
    }
    
}




