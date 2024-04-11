//
//  ProfileView.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit
import SnapKit

class ProfileView: BaseView {
    let testLabel: UILabel = {
       let label = UILabel()
        label.text = "Profile View"
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(testLabel)
    }
    
    override func configureConstraints() {
        testLabel.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
    }
}
