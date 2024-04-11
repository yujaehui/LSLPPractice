//
//  LoginViewController.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    let viewModel = LoginViewModel()
    
    let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bind() {
        let joinButtonTap = loginView.joinButton.rx.tap.asObservable()
        let input = LoginViewModel.Input(joinButtonTap: joinButtonTap)
        
        let output = viewModel.transform(input: input)
        output.joinButtonTap.bind(with: self) { owner, _ in
            owner.navigationController?.pushViewController(JoinViewController(), animated: true)
        }.disposed(by: disposeBag)
    }
}
