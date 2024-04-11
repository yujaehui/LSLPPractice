//
//  NetworkManager.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import Foundation
import Alamofire
import RxSwift

struct NetworkManager {
    
    static func join(query: JoinQuery) -> Single<JoinModel> {
        return Single<JoinModel>.create { single in
            do {
                let urlRequest = try Router.join(query: query).asURLRequest()
                AF.request(urlRequest)
                    .responseDecodable(of: JoinModel.self) { response in
                    switch response.result {
                    case .success(let success):
                        single(.success(success))
                    case .failure(let failure):
                        single(.failure(failure))
                    }
                }
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    static func login(query: LoginQuery) -> Single<LoginModel> {
        return Single<LoginModel>.create { single in
            do {
                let urlRequest = try Router.login(query: query).asURLRequest()
                AF.request(urlRequest)
                    .responseDecodable(of: LoginModel.self) { response in
                    switch response.result {
                    case .success(let success):
                        single(.success(success))
                    case .failure(let failure):
                        single(.failure(failure))
                    }
                }
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    static func profileCheck() -> Single<ProfileModel> {
        return Single<ProfileModel>.create { single in
            do {
                let urlRequest = try Router.profileCheck.asURLRequest()
                AF.request(urlRequest)
                    .responseDecodable(of: ProfileModel.self) { response in
                        switch response.result {
                        case .success(let success):
                            single(.success(success))
                        case .failure(let failure):
                            single(.failure(failure))
                        }
                    }
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }
}
