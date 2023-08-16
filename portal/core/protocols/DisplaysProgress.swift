//  
//  DisplaysProgress.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation
import MBProgressHUD
import UIKit

protocol DisplaysProgress {

	var viewForHUD: UIView { get }

	func showProgress()

	func hideProgress()

}

extension DisplaysProgress {

	func showProgress() {
		MBProgressHUD.showAdded(to: viewForHUD, animated: true)
	}

	func hideProgress() {
		MBProgressHUD.hide(for: viewForHUD, animated: true)
	}
}

