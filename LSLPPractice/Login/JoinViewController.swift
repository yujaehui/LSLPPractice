//
//  JoinViewController.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class JoinViewController: BaseViewController {
    
    let viewModel = JoinViewModel()
    
    let joinView = JoinView()
    
    override func loadView() {
        self.view = joinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bind() {
        let nickname = joinView.nicknameTextField.rx.text.orEmpty.asObservable()
        let email = joinView.emailTextField.rx.text.orEmpty.asObservable()
        let password = joinView.passwordTextField.rx.text.orEmpty.asObservable()
        let joinButtonTap = joinView.joinButton.rx.tap.asObservable()
        let input = JoinViewModel.Input(nickname: nickname, email: email, password: password, joinButtonTap: joinButtonTap)
        
        let output = viewModel.transform(input: input)
        output.joinValidation.drive(joinView.joinButton.rx.isEnabled).disposed(by: disposeBag)
        output.joinSuccessTrigger.drive(with: self) { owner, _ in
            owner.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
    }
}
