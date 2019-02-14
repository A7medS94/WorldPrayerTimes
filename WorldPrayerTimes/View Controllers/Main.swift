//
//  ViewController.swift
//  WorldPrayerTimes
//
//  Created by Ahmed Samir on 1/30/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import UIKit
import Foundation


class Main: UIViewController, UITextFieldDelegate , UITableViewDataSource , UITableViewDelegate {
    
    //Outlets
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var countriesTableView: UITableView!
    @IBOutlet weak var selectBtnOL: UIButton!
    @IBOutlet weak var countriesListView: UIView!
    @IBOutlet weak var searchBtnOL: UIButton!
    @IBOutlet weak var cityTxtOL: UITextField!
    @IBOutlet weak var datePickerOL: UIDatePicker!
    
    //Vars
    var PRAYER_DATA_HANDLEROB : PrayerTimeHandler!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.searchBtnOL.layer.cornerRadius = 20
        self.selectBtnOL.layer.cornerRadius = 10
        
        cityTxtOL.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
    }
    
    
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: sender.date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MM-yyyy"
        let STRING_DATE = formatter.string(from: yourDate!)
        
        DATE = STRING_DATE
        
        let year = NSString(string: STRING_DATE)
        let yearAfterSub = year.substring(from: 6)
        YEAR = String(yearAfterSub)
        
        let startIndex = STRING_DATE.index(STRING_DATE.startIndex, offsetBy: 3)
        let endIndex = STRING_DATE.index(STRING_DATE.startIndex, offsetBy: 5)
        let month : String = STRING_DATE
        let monthAfterSub = month.substring(with: startIndex..<endIndex)
        MONTH = monthAfterSub
    }
    
    
    
    
    @IBAction func searchBtnAction(_ sender: Any) {
        
        reset()
        
        guard let CITY_NAME = cityTxtOL.text else {return}
        
        if cityTxtOL.text?.isEmpty == true {
            
            let alert = UIAlertController(title: "Alert", message: "Fill The City Name!", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Ok", style: .cancel) { (UIAlertAction) in
                
                self.dismiss(animated: false, completion: nil)
                self.cityTxtOL.text?.removeAll()
            }
            
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        }
            
        else if CHOOSEN_COUNTRY == nil {
            
            let alert = UIAlertController(title: "Alert", message: "Choose a country name!", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Ok", style: .cancel) { (UIAlertAction) in
                self.cityTxtOL.resignFirstResponder()
                self.dismiss(animated: false, completion: nil)
            }
            
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
            
        }
            
        else {
            
            let FIRST_URL = "http://api.aladhan.com/v1/calendarByCity?city="
            let SECOND_URL = "&country="
            let END_URL = "&method=2&month="
            
            guard let YEAR_CHOOSEN = YEAR else {return}
            guard let MONTH_CHOOSEN = MONTH else {return}
            guard let choosen_COUNTRY = CHOOSEN_COUNTRY else {return}
            
            let url = URL(string: FIRST_URL + CITY_NAME + SECOND_URL + choosen_COUNTRY + END_URL + MONTH_CHOOSEN + "&year=" + YEAR_CHOOSEN)
            
            if let FINAL_URL = url {
                dataRequest(FINAL_URL: FINAL_URL)
            }
            else {
                print("404 ERROR")
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dataRequest (FINAL_URL : URL) {
        
        if Reachability.isConnectedToNetwork(){
            
            let task = URLSession.shared.dataTask(with: FINAL_URL){
                (data,response,error) in
                
                if let URLresponse = response {
                    print(URLresponse)
                }
                if let URLerror = error {
                    print(URLerror)
                }
                if let URLdata = data {
                    print(URLdata)
                    
                    self.PRAYER_DATA_HANDLEROB = PrayerTimeHandler.init(_data: URLdata)
                    self.PRAYER_DATA_HANDLEROB.decodeData()
                    
                    let delay = DispatchTime.now() + 1
                    DispatchQueue.main.asyncAfter(deadline: delay, execute: {
                        self.wayToDisplayData()
                    })
                    
                }
            }
            
            task.resume()
            
        }else{
            
            
            let alert = UIAlertController(title: "Alert", message: "Please check your internet connection", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Ok", style: .cancel) { (UIAlertAction) in
                
                self.dismiss(animated: false, completion: nil)
                self.cityTxtOL.text?.removeAll()
            }
            
            alert.addAction(cancel)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func wayToDisplayData(){
        
        guard let prayerDataHandler = PRAYER_DATA_HANDLEROB else {return}
        
        CHOOSEN_DATE = prayerDataHandler.choosenDate
        CHOOSEN_CITY = prayerDataHandler.choosenCity
        FAJR = prayerDataHandler.choosenFajr
        SUNRISE = prayerDataHandler.choosenSunrise
        DHUHR = prayerDataHandler.choosenDhuhr
        ASR = prayerDataHandler.choosenAsr
        SUNSET = prayerDataHandler.choosenSunset
        MAGHRIB = prayerDataHandler.choosenMaghrib
        ISHA = prayerDataHandler.choosenIsha
        
        if CHOOSEN_DATE != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let displayVC = storyboard.instantiateViewController(withIdentifier: "DisplayVC")
            self.present(displayVC, animated: true, completion: nil)
        }
    }
    
    
    
    func reset(){
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: datePickerOL.date)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-MM-yyyy"
        let STRING_DATE = formatter.string(from: yourDate!)
        
        DATE = STRING_DATE
        
        let year = NSString(string: STRING_DATE)
        let yearAfterSub = year.substring(from: 6)
        YEAR = String(yearAfterSub)
        
        let startIndex = STRING_DATE.index(STRING_DATE.startIndex, offsetBy: 3)
        let endIndex = STRING_DATE.index(STRING_DATE.startIndex, offsetBy: 5)
        let date : String = STRING_DATE
        let monthAfterSubstring = date.substring(with: startIndex..<endIndex)
        MONTH = monthAfterSubstring
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 120)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 120)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    @IBAction func selectCountryBtn(_ sender: Any) {
        shadow.isHidden = false
        countriesListView.isHidden = false
        countriesTableView.reloadData()
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        shadow.isHidden = true
        countriesListView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcell", for: indexPath) as? CountriesCells {
            
            cell.countriesCellsLbl?.text = countries[indexPath.row]
            
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var choosen_country = countries[indexPath.row]
        CHoosen_country_with_speaces = choosen_country
        countryNameLbl.text = choosen_country
        let speace = "%20"
        let Speaceing = " "
        
        for index in choosen_country.indices{
            
            if choosen_country[index] == Character(Speaceing){
                
                let endIndex = choosen_country.index(after: index)
                let charRange = index..<endIndex
                
                choosen_country = choosen_country.replacingCharacters(in: charRange, with: speace)
            }
        }
        
        CHOOSEN_COUNTRY = choosen_country
        
        shadow.isHidden = true
        countriesListView.isHidden = true
        
    }
}

