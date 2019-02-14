//
//  Prayer Time Struct.swift
//  WorldPrayerTimes
//
//  Created by Ahmed Samir on 1/30/19.
//  Copyright © 2019 Ahmed Samir. All rights reserved.
//

import Foundation


struct PrayerTimesData : Codable {
    
    let code : Int
    let status : String
    let data : [DataTime]
    
}


struct DataTime : Codable{
    
    let timings : Timings
    let date : JSONDate
    let meta : Meta
    
}


struct Timings : Codable { //Under Data Struct
    
    let Fajr : String
    let Sunrise : String
    let Dhuhr : String
    let Asr : String
    let Sunset : String
    let Maghrib : String
    let Isha : String
    let Imsak : String
    let Midnight : String
    
}


struct JSONDate : Codable { //Under Data Struct
    
    let readable : String
    let timestamp : String
    let gregorian : Gregorian
    let hijri : Hijri
    
}


struct Gregorian : Codable { //Under Date
    
    let date : String
    let format : String
    let day : String
    let weekday : GregorianWeekday
    let month : GregorianMonth
    let year : String
    
}


struct GregorianWeekday : Codable { //Under Gregorian
    
    let en : String
    
}

struct GregorianMonth : Codable { //Under Gregorian
    
    let number : Int
    let en : String
    
}

struct Hijri : Codable {
    
    let date : String
    let format : String
    let day : String
    let weekday : HijriWeekday
    let month : HijriMonth
    let year : String
    
}

struct HijriWeekday : Codable { //Under Hijri
    
    let en : String
    let ar : String
    
}

struct HijriMonth : Codable { //Under Hijri
    
    let number : Int
    let en : String
    let ar : String
}


struct Meta : Codable { //Under Data Struct
    
    let latitude : Double
    let longitude : Double
    let timezone : String
    
}


