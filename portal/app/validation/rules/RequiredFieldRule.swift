//  
//  RequiredFieldRule.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

struct RequiredFieldRule: StringValidatorRule {

	var message: String = "This field is required."

	func validate(value: String) -> Bool {
		guard let value = value.trimmed else { return false }
		return !value.isEmpty
	}

}
