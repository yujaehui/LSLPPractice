//
//  JoinView.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit
import SnapKit

class JoinView: BaseView {
    let nicknameLabel = JoinLabel(type: .nickname)
    let nicknameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "사용하실 닉네임을 입력해주세요."
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let emailLabel = JoinLabel(type: .email)
    let emailTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "사용하실 이메일을 입력해주세요."
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordLabel = JoinLabel(type: .password)
    let passwordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "사용하실 비밀번호를 입력해주세요."
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let joinButton: UIButton = {
       let button = UIButton()
        button.configuration = .join2()
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(nicknameLabel)
        addSubview(nicknameTextField)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(joinButton)
    }
    
    override func configureConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(150)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
}
