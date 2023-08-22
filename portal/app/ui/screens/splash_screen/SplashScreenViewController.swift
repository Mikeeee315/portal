//  
//  SplashScreenViewController.swift
//  portal
//
//  Created by Michael de Guzman on 8/18/23.
//

import UIKit
import MBProgressHUD
import RxCocoa
import RxSwift

protocol SplashScreenViewControllerDelegate: AnyObject {
    func dismiss(_ vc: SplashScreenViewController)
}

class SplashScreenViewController: BaseViewController, CreatedFromNib, DisplaysProgress {

    weak var delegate: SplashScreenViewControllerDelegate?

    // MARK: - Outlets

    // MARK: - DisplaysProgress

    var viewForHUD: UIView {
        return self.view
    }

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        initViewModel()
    }

    // MARK: - ViewModel

	var viewModel:  SplashScreenViewModel!
	var inputs: SplashScreenViewModelInputs { return viewModel.inputs }
	var outputs: SplashScreenViewModelOutputs { return viewModel.outputs }

    // MARK: - Private

    private var disposeBag = DisposeBag()

    // MARK: - Deinit

    deinit {
        print("--Deallocating \(self)")
    }

}

// MARK: - Init views
extension SplashScreenViewController {

    private func initViews() {
    }

}

// MARK: - Bindings
extension SplashScreenViewController {

    private func initViewModel() {
        bindInputs()
        bindOutputs()
    }

    private func bindInputs() {

    }

    private func bindOutputs() {

        outputs
            .isProcessing
            .asDriver()
            .drive(onNext: { [unowned self] (isProcessing) in
                if isProcessing {
                    self.showProgress()
                } else {
                    self.hideProgress()
                }
            }).disposed(by: disposeBag)

        outputs
            .errorMessage
            .asDriver()
            .filter { !$0.isEmpty }
            .drive(onNext: { [unowned self] (errorMessage) in
                self.showAlert(type: .error, title: nil, message: errorMessage)
            }).disposed(by: disposeBag)

    }

}
