//
//  LocalTimeCalculator.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 16.07.2022.
//

import Foundation

class LocalTimeCalculator {
    
    static let shared = LocalTimeCalculator()
    let moscowGmt = 3
    
    func getSecondsFromGMT() -> Int {
        return TimeZone.current.secondsFromGMT()
        
    }
    
    func getLocalTimeZoneAbbreviation() -> String {
        return TimeZone.current.abbreviation() ?? ""
        
    }
    
    func getDayOfWeek() -> Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let day = dateFormatter.string(from: date).capitalized
        var result = 0
        
        switch day {
            case "Mon":
                result = 1
            case "Tue":
                result = 2
            case "Wed":
                result = 3
            case "Thu":
                result = 4
            case "Fri":
                result = 5
            case "Sat":
                result = 6
            case "Sun":
                result = 7
            default: print(0)
        }
        
        return result
    }
    
    func calcOfficeWorkTime(openHours: String, closeHours: String) -> String {
        var result  = ""
        let openH   = Double(openHours) ?? 0.0
        let closeH  = Double(closeHours) ?? 0.0
        let localTimeZone = LocalTimeCalculator.shared.getSecondsFromGMT()/60/60
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: localTimeZone*60*60)
        let localHours = Int(dateFormatter.string(from: date))!
        
        if (localHours >= Int(openH)) && (localHours <= Int(closeH)) {
            result = "Открыт"
        } else {
            result = "Закрыт"
        }


        return result
    }
    
        
    
}
