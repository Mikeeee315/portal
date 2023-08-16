//  
//  String+asLocalDate.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

extension String {

	func asLocalDate(dateTimeFormat: DateTimeFormat) -> Date? {
		let formatter = DateFormatter()
        formatter.dateFormat = dateTimeFormat.rawValue
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self)
	}
	
}
