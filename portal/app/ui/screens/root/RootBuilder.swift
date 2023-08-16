//  
//  RootBuilder.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation

class RootBuilder {
    
    static func build() -> RootViewController {
        let vc = RootViewController.createFromNib()

		let viewModel: RootViewModel = {
			let dependency = RootViewModel.Dependency()
			return RootViewModel(dependency: dependency)
		}()

		vc.viewModel = viewModel

        return vc
    }
    
}
