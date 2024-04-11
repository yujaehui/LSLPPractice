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
                            UserDefaults.standard.set(success.accessToken, forKey: "accessToken")
                            UserDefaults.standard.set(success.refreshToken, forKey: "refreshToken")
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
                AF.request(urlRequest, interceptor: AuthInterceptor())
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
    
    static func withdraw() -> Single<WithdrawModel> {
        return Single<WithdrawModel>.create { single in
            do {
                let urlRequest = try Router.withdraw.asURLRequest()
                AF.request(urlRequest)
                    .responseDecodable(of: WithdrawModel.self) { response in
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
    
    static func refresh() -> Single<TokenModel> {
        return Single<TokenModel>.create { single in
            do {
                let urlRequest = try Router.refresh.asURLRequest()
                AF.request(urlRequest)
                    .responseDecodable(of: TokenModel.self) { response in
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

class AuthInterceptor: RequestInterceptor {
    
    let disposeBag = DisposeBag()
    
    func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            urlRequest.setValue(accessToken, forHTTPHeaderField: HTTPHeader.authorization.rawValue)
        }
        completion(.success(urlRequest))
    }

    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print(#function)
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 419 else {
            print("재시도 X")
            completion(.doNotRetry)
            return
        }
        
        // 토큰을 갱신합니다.
        NetworkManager.refresh()
            .debug("Refresh")
            .subscribe { event in
                switch event {
                case .success(let success):
                    UserDefaults.standard.set(success.accessToken, forKey: "accessToken")
                    completion(.retry)
                case .failure(let error):
                    completion(.doNotRetryWithError(error))
                }
            }
            .disposed(by: disposeBag)
    }
}
