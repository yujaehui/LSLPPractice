//
//  HomeViewController.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit

class HomeViewController: BaseViewController {
    
    let homeView = HomeView()
    
    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
    }
    
    func setNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
    }
    
    @objc func rightBarButtonClicked() {
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
}
