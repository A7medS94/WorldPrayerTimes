//
//  DisplayVC.swift
//  WorldPrayerTimes
//
//  Created by Ahmed Samir on 1/31/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit



class DisplayVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var displayChoosenDateLbl: UILabel!
    @IBOutlet weak var displayChoosenCountryAndCityLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayTheFinalData()
    }
    
    
    func displayTheFinalData(){
        
        self.displayChoosenDateLbl.text = CHOOSEN_DATE
        self.displayChoosenCountryAndCityLbl.text = "\(CHOOSEN_CITY!)"
        
    }
}
