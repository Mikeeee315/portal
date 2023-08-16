//  
//  CoordinatorType.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

protocol CoordinatorType: AnyObject {

	var childCoordinators: [CoordinatorType] { get set }
	func start()

}

extension CoordinatorType {

	func add(_ childCoordinator: CoordinatorType) {
		childCoordinators.append(childCoordinator)
	}

	func remove(_ childCoordinator: CoordinatorType) {
		childCoordinators.removeAll(where: { $0 === childCoordinator })
	}

}
