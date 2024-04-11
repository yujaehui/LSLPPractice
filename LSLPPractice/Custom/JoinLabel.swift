//
//  JoinLabel.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit

class JoinLabel: UILabel {
    enum LabelType: String {
        case nickname = "닉네임"
        case email = "이메일"
        case password = "비밀번호"
        
        var font: UIFont {
            .boldSystemFont(ofSize: 16)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(type: LabelType) {
        self.init(frame: .zero)
        configureView(type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(_ type: LabelType) {
        font = type.font
        text = type.rawValue
    }
}
