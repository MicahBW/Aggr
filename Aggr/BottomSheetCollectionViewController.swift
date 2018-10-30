//
//  BottomSheetCollectionViewController.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 10/25/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//




import UIKit
import CoreLocation
import CoreData
import GoogleMaps
import GooglePlaces


private let reuseIdentifier = "Cell"

class BottomSheetCollectionViewController: UICollectionViewController {
    
    //let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

    let items = [Vehicle(location: Constants.MapTesting.TestCoordinates.tc1, company: Company.ofo, type: VehicleType.bike, scooterInfo: nil), Vehicle(location: Constants.MapTesting.TestCoordinates.tc2, company: Company.ofo, type: VehicleType.bike, scooterInfo: nil), Vehicle(location: Constants.MapTesting.TestCoordinates.tc3, company: Company.ofo, type: VehicleType.bike, scooterInfo: nil)]
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        
        print("okay")
        super.viewDidLoad()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(VehicleCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        
        
        
        
        // add pan gesture recognizer
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetCollectionViewController.panGesture))
        view.addGestureRecognizer(gesture)
        

        // mine
        
        self.collectionView?.backgroundColor = UIColor(white: 1, alpha: 0.8)
    }
    
    
    

    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VehicleCollectionCell
    
        // Configure the cell
        
        cell.configureForVehicle(items[indexPath.item])
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    
    
    
    
    //MARK: - My Functions
    
    
    
    //MARK: - Bottom Sliding Functions
    
    
    /// Blurs what is under the bottom view in its current state
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let blurredView = UIVisualEffectView.init(effect: blurEffect)
        blurredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        blurredView.frame = UIScreen.main.bounds
        
        view.insertSubview(blurredView, at: 0)
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
        self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(CGPoint(), in: self.view)
    }
    
    
    
    //
    
    
}
