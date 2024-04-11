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
    }
    
    struct Output {
        let joinButtonTap: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(joinButtonTap: input.joinButtonTap)
    }
}
