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
        let email = loginView.emailTextField.rx.text.orEmpty.asObservable()
        let password = loginView.passwordTextField.rx.text.orEmpty.asObservable()
        let loginButtonTap = loginView.loginButton.rx.tap.asObservable()
        let input = LoginViewModel.Input(joinButtonTap: joinButtonTap, email: email, password: password, loginButtonTap: loginButtonTap)
        
        let output = viewModel.transform(input: input)
        output.joinButtonTap.bind(with: self) { owner, _ in
            owner.navigationController?.pushViewController(JoinViewController(), animated: true)
        }.disposed(by: disposeBag)
        output.loginValidation.drive(loginView.loginButton.rx.isEnabled).disposed(by: disposeBag)
        output.loginSuccessTrigger.drive(with: self) { owner, _ in
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            let vc = UINavigationController(rootViewController: ProfileViewController())
            sceneDelegate?.window?.rootViewController = vc
            sceneDelegate?.window?.makeKeyAndVisible()
        }.disposed(by: disposeBag)
    }
}
