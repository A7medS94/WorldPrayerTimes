//
//  Prayer Times Data Handler.swift
//  WorldPrayerTimes
//
//  Created by Ahmed Samir on 1/30/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation

class PrayerTimeHandler{
    
    
    var JSONPrayerData : PrayerTimesData?
    
    let data : Data
    var choosenDate : String?
    var choosenFajr : String?
    var choosenSunrise : String?
    var choosenDhuhr : String?
    var choosenAsr : String?
    var choosenSunset : String?
    var choosenMaghrib : String?
    var choosenIsha : String?
    var choosenCity : String?
    
    
    
    
    init(_data : Data) {
        self.data = _data
    }
    
    
    func decodeData() {
        
        let decoder = JSONDecoder()
        
        do{
            
            JSONPrayerData = try decoder.decode(PrayerTimesData.self, from: self.data)
            
            gettingTheChoosenData(jsonprayerdata: JSONPrayerData)
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    
    func gettingTheChoosenData (jsonprayerdata : PrayerTimesData?) {
        
        guard let JSONdata = jsonprayerdata else {return}
        
        
        for choosen in JSONdata.data {
            
            let date : String = DATE!
            
            if choosen.date.gregorian.date == date {
                
                choosenDate = choosen.date.gregorian.date
                choosenCity = choosen.meta.timezone
                
                let fajr = choosen.timings.Fajr
                let sunrise = choosen.timings.Sunrise
                let dhuhr = choosen.timings.Dhuhr
                let asr = choosen.timings.Asr
                let sunset = choosen.timings.Sunset
                let maghrib = choosen.timings.Maghrib
                let isha = choosen.timings.Isha
                
                stringHandler(fajr: fajr, sunrise: sunrise , dhuhr: dhuhr, asr: asr, sunset: sunset , maghrib: maghrib, isha: isha)
            }
        }
    }
    
    func stringHandler(fajr : String , sunrise : String , dhuhr : String , asr : String , sunset : String , maghrib : String , isha : String){
        
        let fajr = fajr
        let sunrise = sunrise
        let dhuhr = dhuhr
        let asr = asr
        let sunset = sunset
        let maghrib = maghrib
        let isha = isha
        
        
        let index = fajr.index(fajr.startIndex, offsetBy: 5)
        
        
        let FAJR_NEW = fajr[..<index]
        let SUNRISE_NEW = sunrise[..<index]
        let DHUHR_NEW = dhuhr[..<index]
        let ASR_NEW = asr[..<index]
        let SUNSET_NEW = sunset[..<index]
        let MAGHRIB_NEW = maghrib[..<index]
        let ISHA_NEW = isha[..<index]
        
        
        
        let fajrN = String(FAJR_NEW)
        let sunriseN = String(SUNRISE_NEW)
        let dhuhrN = String(DHUHR_NEW)
        let asrN = String(ASR_NEW)
        let sunsetN = String(SUNSET_NEW)
        let maghribN = String(MAGHRIB_NEW)
        let ishaN = String(ISHA_NEW)
        
        
        timeFormat(fajr_new: fajrN, sunrise_new: sunriseN, dhuhr_new: dhuhrN, asr_new: asrN, sunset_new: sunsetN, maghrib_new: maghribN, isha_new: ishaN)
    }
    
    
    func timeFormat(fajr_new : String , sunrise_new : String , dhuhr_new : String , asr_new : String , sunset_new : String , maghrib_new : String , isha_new : String){
        
        
        let FAJR_TIME = fajr_new
        let SUNRISE_TIME = sunrise_new
        let DHUHR_TIME = dhuhr_new
        let ASR_TIME = asr_new
        let SUNSET_TIME = sunset_new
        let MAGHRIB_TIME = maghrib_new
        let ISHA_TIME = isha_new
        
        
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "HH:mm"
        let date1 = dateFormatter1.date(from: FAJR_TIME)
        dateFormatter1.dateFormat = "h:mm a"
        let Fajr12 = dateFormatter1.string(from: date1!)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm"
        let date2 = dateFormatter2.date(from: SUNRISE_TIME)
        dateFormatter2.dateFormat = "h:mm a"
        let Sunrise12 = dateFormatter2.string(from: date2!)
        
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = "HH:mm"
        let date3 = dateFormatter3.date(from: DHUHR_TIME)
        dateFormatter3.dateFormat = "h:mm a"
        let Dhuhr12 = dateFormatter3.string(from: date3!)
        
        let dateFormatter4 = DateFormatter()
        dateFormatter4.dateFormat = "HH:mm"
        let date4 = dateFormatter4.date(from: ASR_TIME)
        dateFormatter4.dateFormat = "h:mm a"
        let Asr12 = dateFormatter4.string(from: date4!)
        
        let dateFormatter5 = DateFormatter()
        dateFormatter5.dateFormat = "HH:mm"
        let date5 = dateFormatter5.date(from: SUNSET_TIME)
        dateFormatter5.dateFormat = "h:mm a"
        let Sunset12 = dateFormatter5.string(from: date5!)
        
        let dateFormatter6 = DateFormatter()
        dateFormatter6.dateFormat = "HH:mm"
        let date6 = dateFormatter6.date(from: MAGHRIB_TIME)
        dateFormatter6.dateFormat = "h:mm a"
        let Maghrib12 = dateFormatter6.string(from: date6!)
        
        let dateFormatter7 = DateFormatter()
        dateFormatter7.dateFormat = "HH:mm"
        let date7 = dateFormatter7.date(from: ISHA_TIME)
        dateFormatter7.dateFormat = "h:mm a"
        let Isha12 = dateFormatter7.string(from: date7!)
        
        
        
        choosenFajr = Fajr12
        choosenSunrise = Sunrise12
        choosenDhuhr = Dhuhr12
        choosenAsr = Asr12
        choosenSunset = Sunset12
        choosenMaghrib = Maghrib12
        choosenIsha = Isha12
        
    }
}
