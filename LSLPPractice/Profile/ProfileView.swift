//
//  ProfileView.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit
import SnapKit

class ProfileView: BaseView {
    let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .systemTeal
        return imageView
    }()
    
    let profileStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    let nicknameLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let emailLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()
    
    let withdrawButton: UIButton = {
       let button = UIButton()
        button.configuration = .withdraw()
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(profileStackView)
        profileStackView.addArrangedSubview(nicknameLabel)
        profileStackView.addArrangedSubview(emailLabel)
        addSubview(withdrawButton)
    }
    
    override func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(safeAreaLayoutGuide).inset(20)
            make.size.equalTo(80)
        }
        
        profileStackView.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        withdrawButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
}
