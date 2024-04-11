//
//  ProfileViewController.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: BaseViewController {
    
    let viewModel = ProfileViewModel()
    
    let profileView = ProfileView()
    
    override func loadView() {
        self.view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bind() {
        let viewDidLoadTrigger = BehaviorSubject<Void>(value: ()).asObserver()
        let withdrawButtonTap = profileView.withdrawButton.rx.tap.asObservable()
        let input = ProfileViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger, withdrawButtonTap: withdrawButtonTap)
        
        let output = viewModel.transform(input: input)
        output.profile.bind(with: self) { owner, value in
            owner.profileView.nicknameLabel.text = value.nick
            owner.profileView.emailLabel.text = value.email
        }.disposed(by: disposeBag)
        output.withdrawSuccessTrigger.bind(with: self) { owner, _ in
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            let vc = UINavigationController(rootViewController: LoginViewController())
            sceneDelegate?.window?.rootViewController = vc
            sceneDelegate?.window?.makeKeyAndVisible()
        }.disposed(by: disposeBag)
    }
}
