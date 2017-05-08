//
//  TimeCaculate.swift
//  NPOProject
//
//  Created by Cid Hsieh on 2017/5/7.
//  Copyright © 2017年 Cid Hsieh. All rights reserved.
//

import UIKit

class TimeCalculate {
    
    func getToday(format:String = "yyyy/MM/dd HH:mm:ss") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    func convertStringToDate(dateConvert: String) -> Date {
        var date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        if let tempDate = dateFormatter.date(from: dateConvert) {
            date = tempDate
        }
        return date
    }
    
    
    func compareDate(theDate:String) -> String {
        
        let dateCompare = self.convertStringToDate(dateConvert: theDate)
        
        var result = ""
        
        var temp = 0.0
        
        let currentDate = Date()
        
        let timeInterval = currentDate.timeIntervalSince(dateCompare)
        
        if timeInterval/60 < 1 {
            
            result = "剛剛"
            
        }else if timeInterval/60 < 60{
            
            temp = timeInterval/60
            
            result = "\(Int(temp))分鐘前"
            
        }else if timeInterval/(60 * 60)  < 24 {
            
            temp = timeInterval/(60 * 60)
            
            result = "\(Int(temp))小時前"
            
        }else if timeInterval/(24 * 60 * 60) < 30 * 24 * 60 {
            
            temp = timeInterval/(24 * 60 * 60)
            
            result = "\(Int(temp))天前"
            
        }else if timeInterval/(30 * 24 * 60 * 60)  < 12 * 30 * 24 * 60{
            
            temp = timeInterval/(30 * 24 * 60 * 60)
            
            result = "\(Int(temp))個月前"
            
        }else{
            
            temp = timeInterval/(12 * 30 * 24 * 60 * 60)
            
            result = "\(Int(temp))年前"
            
        }
        print("\(result)")

        return result
    }
    
}
