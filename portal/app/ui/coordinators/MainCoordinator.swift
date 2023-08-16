//  
//  MainCoordinator.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

// (mark) learn more here :) -> https://khanlou.com/2015/01/the-coordinator/

import Foundation
import UIKit

class MainCoordinator: CoordinatorType {

	var childCoordinators: [CoordinatorType] = []

	lazy var rootVc: RootViewController = {
		let rootVc = RootBuilder.build()
		rootVc.delegate = self
		return rootVc
	}()

	lazy var navigationVc: BaseNavigationController = {
		let navigationVc = BaseNavigationController(rootViewController: rootVc)
		return navigationVc
	}()

	init() {
	}

	func start() {
	}

	deinit {
		print("--Deallocating \(self)")
	}

}

extension MainCoordinator: RootViewControllerDelegate {

	func dismiss(_ vc: RootViewController) {
	}

}
