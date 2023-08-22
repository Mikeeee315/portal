//  
//  SplashScreenViewModel.swift
//  portal
//
//  Created by Michael de Guzman on 8/18/23.
//

import Foundation
import RxCocoa
import RxSwift

protocol SplashScreenViewModelInputs {
//    func getElements()
}

protocol SplashScreenViewModelOutputs {
    var isProcessing: BehaviorRelay<Bool> { get }
    var errorMessage: BehaviorRelay<String> { get }
}

class SplashScreenViewModel: SplashScreenViewModelOutputs {

    // MARK: - Init
    
	struct Dependency {
	}

	init(dependency: Dependency) {
		self.dependency = dependency
	}
    
    var inputs: SplashScreenViewModelInputs { return self }
    var outputs: SplashScreenViewModelOutputs { return self }
    
    // MARK: - Outputs
    
    let isProcessing: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let errorMessage: BehaviorRelay<String> = BehaviorRelay(value: "")

	// MARK: - Private

	private var dependency: Dependency
	private var disposeBag = DisposeBag()

    // MARK: - Deinit
    
	deinit {
		print("--Deallocating \(self)")
	}

}

// MARK: - Input(s)

extension SplashScreenViewModel: SplashScreenViewModelInputs {
    
//	func getElements() {
//
//	}

}
