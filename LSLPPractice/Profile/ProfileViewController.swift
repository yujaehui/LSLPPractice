//
//  ProfileViewController.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    let profileView = ProfileView()
    
    override func loadView() {
        self.view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
