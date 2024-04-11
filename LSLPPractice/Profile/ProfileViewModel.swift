//
//  ProfileViewModel.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    let disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void>
    }
    
    struct Output {
        let profile: PublishSubject<ProfileModel>
    }
    
    func transform(input: Input) -> Output {
        
        let profile = PublishSubject<ProfileModel>()
        
        input.viewDidLoadTrigger
            .flatMap { _ in
                NetworkManager.profileCheck()
            }
            .subscribe(with: self) { owner, value in
                profile.onNext(value)
            }.disposed(by: disposeBag)
        
        return Output(profile: profile)
    }
}
