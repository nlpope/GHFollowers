//
//  String+Ext.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/18/24.
//

import Foundation

extension String {
    //see site https://www.nsdateformatter.com/
    
    func convertToDate() -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = .current
        
        
        return dateFormatter.date(from: self)
    }
    
    
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        
        return date.convertToMonthYearFormat()
    }
}


