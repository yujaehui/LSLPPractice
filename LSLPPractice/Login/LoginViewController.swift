//
//  LoginViewController.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit

class LoginViewController: BaseViewController {
    
    let loginView = LoginView()
    
    override func loadView() {
        self.view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
