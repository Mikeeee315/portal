//  
//  subscribe2.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation
import Moya
import RxSwift

extension ObservableType  {

    func subscribe2(_ on: @escaping (RxSwift.Event<Self.Element>) -> Void) -> Disposable {
        return subscribe({ (event) in
            switch event {
            case .next(let element):
                on(.next(element))
            case .error(let error):

//                let conditionToSilenceError = false
//
//                if conditionToSilenceError {
//                    on(.completed)
//                } else {
                    on(.error(error))
//                }

            case .completed:
                on(.completed)
            }
        })
    }

}
