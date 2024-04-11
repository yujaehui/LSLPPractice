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
        let input = ProfileViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger)
        
        let output = viewModel.transform(input: input)
        output.profile.bind(with: self) { owner, value in
            owner.profileView.nicknameLabel.text = value.nick
            owner.profileView.emailLabel.text = value.email
        }.disposed(by: disposeBag)
    }
}
