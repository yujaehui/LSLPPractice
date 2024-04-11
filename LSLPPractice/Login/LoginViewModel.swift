//
//  LoginViewModel.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let joinButtonTap: Observable<Void>
        let email: Observable<String>
        let password: Observable<String>
        let loginButtonTap: Observable<Void>
    }
    
    struct Output {
        let joinButtonTap: Observable<Void>
        let loginValidation: Driver<Bool>
        let loginSuccessTrigger: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let loginValidation = BehaviorSubject<Bool>(value: false)
        let loginSuccessTrigger = PublishSubject<Void>()
        
        let loginObservable = Observable.combineLatest(input.email, input.password).map { (email, password) in
            return LoginQuery(email: email, password: password)
        }
        
        loginObservable.bind(with: self) { owner, value in
            if value.email.count > 0 && value.password.count > 0 {
                loginValidation.onNext(true)
            } else {
                loginValidation.onNext(false)
            }
        }.disposed(by: disposeBag)
        
        input.loginButtonTap
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(loginObservable)
            .flatMap { loginQuery in
                return NetworkManager.login(query: loginQuery)
            }
            .debug()
            .subscribe(with: self) { owner, value in
                UserDefaults.standard.set(value.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(value.refreshToken, forKey: "refreshToken")
                loginSuccessTrigger.onNext(())
            } onError: { owner, error in
                print("오류 발생")
            }.disposed(by: disposeBag)
        
        return Output(joinButtonTap: input.joinButtonTap, loginValidation: loginValidation.asDriver(onErrorJustReturn: false), loginSuccessTrigger: loginSuccessTrigger.asDriver(onErrorJustReturn: ()))
    }
}
