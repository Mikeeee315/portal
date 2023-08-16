//  
//  request2.swift
//  portal
//
//  Created by Michael de Guzman on 8/16/23.
//

import Foundation
import Moya
import RxSwift

extension ApiProvider {

    func request2(_ service: ApiService) -> Observable<Response> {
        let decoder = ApiJSONDecoder.shared
        
        return self.rx.request(service)
            .filterSuccessfulStatusCodes()
            .catchError { e in

                guard let error = e as? MoyaError else {
                    throw e
                }

                guard case .statusCode(let errResp) = error else {
                    throw error
                }

                if errResp.statusCode == 401 && service.shouldAutoRefreshToken, let accessToken = KeychainHelper.shared.accessToken {

					let keychain = KeychainHelper.shared
                    let params = RefreshTokenParams(refreshToken: keychain.refreshToken ?? "")
                    return self.request2(.refreshToken(params)).map2(RefreshTokenResponse.self).flatMap({ (data) -> Observable<Response> in
                        keychain.refreshToken = data.refreshToken
                        keychain.accessToken = data.accessToken
                        return self.request2(service)
                    }).asSingle()

                }

                guard let apiError = try? errResp.map(ApiError.self, using: decoder) else {
                    throw error
                }

                throw apiError

            }
            .asObservable()
    }
    
}
