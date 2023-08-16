//  
//  CreatedFromNib.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation
import UIKit

protocol CreatedFromNib {

	static func createFromNib() -> Self

}

extension CreatedFromNib where Self: UIViewController {

	static func createFromNib() -> Self {
		let nibName = String(describing: self)
		return Self.init(nibName: nibName, bundle: nil)
	}

}

