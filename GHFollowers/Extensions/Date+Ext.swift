//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/18/24.
//

import Foundation

extension Date {
    
    //see site https://www.nsdateformatter.com/
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"

        return dateFormatter.string(from: self)
    }
}
