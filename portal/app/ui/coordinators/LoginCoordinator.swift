//  
//  LoginCoordinator.swift
//  portal
//
//  Created by Michael de Guzman on 8/18/23.
//

import Foundation
import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
	func dettach(_ coordinator: LoginCoordinator)
}


class LoginCoordinator: CoordinatorType {

	weak var delegate: LoginCoordinatorDelegate?

    var childCoordinators: [CoordinatorType] = []
	var modalSource: BaseViewController
    
	init(modalSource: BaseViewController) {
        self.modalSource = modalSource
    }
    
    func start() {
    }
    
    deinit {
        print("--Deallocating \(self)")
    }
    
}
