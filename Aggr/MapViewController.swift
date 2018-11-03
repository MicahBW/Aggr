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
    
    
    //@IBOutlet weak var textbox: UITextView!
    //xvar textbox : UITextView!
    
    
    override func loadView() {
        
        // deal with GMS
        let camera = GMSCameraPosition.camera(withLatitude: 38.919389, longitude: -77.0278109, zoom: 15)
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
        
        
        var pullUpController = VehicleListViewController()
        
        addPullUpController(pullUpController, initialStickyPointOffset: 100, animated: true)
        //var textList : [String] = []
        
        /*
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
                //self.view.addSubview(box)
                
                
                
                
            }
            
            
        }
        */
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
