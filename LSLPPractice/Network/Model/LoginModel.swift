//
//  LoginModel.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import Foundation

struct LoginModel: Decodable {
    let user_id: String
    let email: String
    let nick: String
    let accessToken: String
    let refreshToken: String
}
