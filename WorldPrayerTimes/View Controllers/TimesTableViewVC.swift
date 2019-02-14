//
//  TimesTableViewVC.swift
//  WorldPrayerTimes
//
//  Created by Ahmed Samir on 1/31/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit

class TimesTableViewVC: UITableViewController {
    
    
    //Outlets
    @IBOutlet weak var fajrTimeLbl: UILabel!
    @IBOutlet weak var sunriseTimeLbl: UILabel!
    @IBOutlet weak var dhuhrTimeLbl: UILabel!
    @IBOutlet weak var asrTimeLbl: UILabel!
    @IBOutlet weak var sunsetTimeLbl: UILabel!
    @IBOutlet weak var maghribTimeLbl: UILabel!
    @IBOutlet weak var ishaTimeLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayingTimes()
    }
    
    
    
    func displayingTimes (){
        
        if let FAJR = FAJR{
            self.fajrTimeLbl.text = FAJR
        }
        if let SUNRISE = SUNRISE{
            self.sunriseTimeLbl.text = SUNRISE
        }
        if let DHUHR = DHUHR{
            self.dhuhrTimeLbl.text = DHUHR
        }
        if let ASR = ASR{
            self.asrTimeLbl.text = ASR
        }
        if let SUNSET = SUNSET{
            self.sunsetTimeLbl.text = SUNSET
        }
        if let MAGHRIB = MAGHRIB{
            self.maghribTimeLbl.text = MAGHRIB
        }
        if let ISHA = ISHA{
            self.ishaTimeLbl.text = ISHA
        }
        
    }
}
