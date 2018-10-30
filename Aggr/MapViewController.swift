//
//  MapViewController.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 10/25/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class MapViewController: UIViewController, GMSMapViewDelegate {
    
    
    var encompassingView: UIView!
    var mapView: GMSMapView!
    
    
    @IBOutlet weak var textbox: UITextView!
    //xvar textbox : UITextView!
    
    
    override func loadView() {
        
        // deal with GMS
        let camera = GMSCameraPosition.camera(withLatitude: 38.885264, longitude: -77.035857, zoom: 12)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
        
        // add vehicle markers
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let vehList = getVehList()
            for veh in vehList {
                let thisMark : VehicleMarker = VehicleMarker(forVehicle: veh)
                thisMark.map = mapView
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public func addBottomSheetView() {
        /*
        // init bottomSheetVC
        let layout = UICollectionViewFlowLayout()
        let bottomSheetVC = BottomSheetCollectionViewController(collectionViewLayout: layout)
        
        // add bottomSheetVC as a child view
        self.addChildViewController(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParentViewController: self)
        
        // adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
 
        
        */
        /*
        let bottomVC = UIViewController()
        self.addChildViewController(bottomVC)
        self.view.addSubview(bottomVC.view)
        let height = view.frame.height
        let width = view.frame.width
        bottomVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
        
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let blurredView = UIVisualEffectView.init(effect: blurEffect)
        blurredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        blurredView.frame = UIScreen.main.bounds
        
        bottomVC.view.insertSubview(blurredView, at: 0)
 
        
        
        
        var bottext = UIView()
        
        bottext.backgroundColor = .red
        
        //bottext.text = "Hello, World"
        
        bottomVC.view = bottext
        
        */
        
        var textList : [String] = []
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let vehList = getVehList()
        for v in vehList {
            var str = ""
            str = "There is a " + nameOfCompany(v.company) + " " + nameOfVehicleType(v.type) + " " + String(v.distanceFromUser.inMiles)  +  " miles away" + "\n \n" ;
            textList.append(str)
            print("HERE: ", textList)
            var totString = ""
            for text in textList {
                totString += text
            }
            print(totString)
            //self.textbox.frame = self.view.frame
            
            let box = UITextView(frame: CGRect(x: 0, y: self.view.frame.height * 3 / 4, width:  self.view.frame.width, height:  self.view.frame.height - self.view.frame.height * 1 / 4 ))
            box.text = totString
            box.backgroundColor = .white
            box.layer.cornerRadius = 20
            box.font = UIFont(name: "Courier-Bold", size: 14)
            
            box.isEditable = false;
            
            
            
            //box.text = "asdfsfdfadssff"
            
            self.view.addSubview(box)
            

           // self.textbox.text = totString;
            //self.view.addSubview(self.textbox)
            
            
        }
        
        
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheetView()
    }
    
    
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
