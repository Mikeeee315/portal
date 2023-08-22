//  
//  SplashScreenBuilder.swift
//  portal
//
//  Created by Michael de Guzman on 8/18/23.
//

import Foundation

class SplashScreenBuilder {
    
    static func build() -> SplashScreenViewController {
        let vc = SplashScreenViewController.createFromNib()

		let viewModel: SplashScreenViewModel = {
			let dependency = SplashScreenViewModel.Dependency()
			return SplashScreenViewModel(dependency: dependency)
		}()

		vc.viewModel = viewModel

        return vc
    }
    
}
