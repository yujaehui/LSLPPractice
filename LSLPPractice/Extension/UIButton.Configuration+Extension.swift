//
//  UIButton.Configuration+Extension.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import UIKit

extension UIButton.Configuration {
    static func login() -> Self {
        var config = UIButton.Configuration.filled()
        
        var titleAttr = AttributedString.init("로그인")
        titleAttr.font = .boldSystemFont(ofSize: 16)
        config.attributedTitle = titleAttr
        config.titleAlignment = .center
        
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .systemTeal
        config.cornerStyle = .fixed
        return config
    }
    
    static func join() -> Self {
        var config = UIButton.Configuration.borderless()
        
        var titleAttr = AttributedString.init("회원가입")
        titleAttr.font = .systemFont(ofSize: 16)
        config.attributedTitle = titleAttr
        config.titleAlignment = .center
        
        config.baseForegroundColor = .systemTeal
        return config
    }
    
    static func join2() -> Self {
        var config = UIButton.Configuration.filled()
        
        var titleAttr = AttributedString.init("회원가입")
        titleAttr.font = .boldSystemFont(ofSize: 16)
        config.attributedTitle = titleAttr
        config.titleAlignment = .center
        
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .systemTeal
        config.cornerStyle = .fixed
        return config
    }
}


