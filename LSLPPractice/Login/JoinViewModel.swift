//
//  JoinViewModel.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import Foundation
import RxSwift
import RxCocoa

class JoinViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let nickname: Observable<String>
        let email: Observable<String>
        let password: Observable<String>
        let joinButtonTap: Observable<Void>
    }
    
    struct Output {
        let joinValidation: Driver<Bool>
        let joinSuccessTrigger: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let joinValidation = BehaviorSubject<Bool>(value: false)
        let joinSuccessTrigger = PublishSubject<Void>()
        
        let joinObservable = Observable.combineLatest(input.nickname, input.email, input.password).map { (nick, email, password) in
            return JoinQuery(nick: nick, email: email, password: password)
        }
        
        joinObservable.bind(with: self) { owner, value in
            if value.nick.count > 0 && value.email.contains("@") && value.password.count > 5 {
                joinValidation.onNext(true)
            } else {
                joinValidation.onNext(false)
            }
        }.disposed(by: disposeBag)
        
        input.joinButtonTap
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(joinObservable)
            .flatMap { joinQuery in
                return NetworkManager.join(query: joinQuery)
            }
            .debug()
            .subscribe(with: self) { owner, value in
                joinSuccessTrigger.onNext(())
            } onError: { owner, error in
                print("오류 \(error)")
            }.disposed(by: disposeBag)
        
        return Output(joinValidation: joinValidation.asDriver(onErrorJustReturn: false), joinSuccessTrigger: joinSuccessTrigger.asDriver(onErrorJustReturn: ()))
    }
}
