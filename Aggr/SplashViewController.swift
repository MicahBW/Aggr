//
//  SplashViewController.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 11/27/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let splash = SplashView(frame: UIScreen.main.bounds)
        splash.Setup()
        
        self.view = splash
        
        

        // Do any additional setup after loading the view.
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
