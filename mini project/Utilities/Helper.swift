//
//  Helper.swift
//  mini project
//
//  Created by Kawthar Khalid al-Tamimi on 11/10/20.
//  Copyright © 2020 Kawthar. All rights reserved.
//

import Foundation

class Helper {
    
    class func configValue(for key: String) -> String{
          if let value = Bundle.main.object(forInfoDictionaryKey: key) as? String {
              return value
          } else {
              fatalError("check key in plist")
          }
      }

// NOTE - Returning Both Date and Time can be done and is implemented below, but for the sake of simplicity we're returning date only.

    class func getDate(date: String) -> (String){
        
        let trimmedIsoString = date.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = formatter.date(from: trimmedIsoString) {
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "h:mm a"
            formatter2.amSymbol = "AM"
            formatter2.pmSymbol = "PM"
            formatter2.timeZone = TimeZone(abbreviation: "UTC")
            
            let timeStr = formatter2.string(from: date)
            

            formatter2.dateFormat =  "yyyy/MM/dd"
            let dateStr = formatter2.string(from: date)
            
            return (dateStr)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let date = dateFormatter.date(from:date) {
            var onlyDateString = ""
            var onlyTimeString = ""
            if let onlyDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: date)) {
                dateFormatter.dateFormat = "yyyy/MM/dd"
                onlyDateString = dateFormatter.string(from: onlyDate)
            }
            if let onlyTime = Calendar.current.date(from: Calendar.current.dateComponents([.hour,.minute], from: date)) {
                dateFormatter.dateFormat = "hh:mm a"
                dateFormatter.amSymbol = "AM"
                dateFormatter.pmSymbol = "PM"
                onlyTimeString = dateFormatter.string(from: onlyTime)
            }

            return (onlyDateString)
        }
        
        return ("")
        
    }
      
}
