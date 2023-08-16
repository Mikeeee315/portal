//  
//  String+trimmed.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

extension String {

	var trimmed: String? {
		guard !trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
			return nil
		}
		return self
	}

}

