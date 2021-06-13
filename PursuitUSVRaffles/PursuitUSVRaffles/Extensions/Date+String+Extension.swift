//
//  Date+String+Extension.swift
//  PursuitUSVRaffles
//
//  Created by Kelby Mittan on 5/29/21.
//

import Foundation

extension String {
    
    public func dateToString() -> (date: String, time: String) {
        
        var dayAndDate = "No Date"
        var time = "No Time"
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime,
                                       .withFractionalSeconds
        ]
        let date = isoFormatter.date(from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = " h:mm a"
        dayAndDate = dateFormatter.string(from: date ?? Date())
        time = timeFormatter.string(from: date ?? Date())
        return (dayAndDate, time)
    }
    
    public func dateToSeconds() -> Date {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime,
                                      .withFractionalSeconds
        ]
        let date = isoFormatter.date(from: self)
        return date ?? Date()
    }
    
    public func dateToString2() -> (date: String, time: String) {
        var dayAndDate = "No Date"
        var time = "No Time"
        
        var str = self
        str = str.replacingOccurrences(of: "T", with: " ")
        str = str.replacingOccurrences(of: "Z", with: "")
        print(str)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        let dateFromString = dateFormatter.date(from: str)

        let dayAndDateFormatter = DateFormatter()
        dayAndDateFormatter.dateFormat = "EEEE, MMM d"

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        if let validDate = dateFromString {
            dayAndDate = dayAndDateFormatter.string(from: validDate)
            time = timeFormatter.string(from: validDate)
        }
        
        return (dayAndDate, time)
    }

}

