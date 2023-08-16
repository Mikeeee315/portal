//  
//  Date+asString.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

extension Date {
    
    func asString(dateTimeFormat: DateTimeFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateTimeFormat.rawValue
        return formatter.string(from: self)
    }
    
}
