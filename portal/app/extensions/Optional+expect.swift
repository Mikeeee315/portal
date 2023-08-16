//  
//  Optional+expect.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

extension Optional {

	func expect(_ message: String) -> Wrapped {
		switch self {
		case .some(let value):
			return value
		case .none:
			fatalError(message)
		}
	}

}
