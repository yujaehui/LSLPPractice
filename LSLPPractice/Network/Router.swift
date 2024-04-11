//
//  Router.swift
//  LSLPPractice
//
//  Created by Jaehui Yu on 4/11/24.
//

import Foundation
import Alamofire

enum Router {
    case join(query: JoinQuery)
    case login(query: LoginQuery)
    case refresh
    case withdraw
    case profileCheck
}

extension Router: TargetType {
    
    var baseURL: String {
        APIKey.baseURL.rawValue
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .join: .post
        case .login: .post
        case .refresh: .get
        case .withdraw: .get
        case .profileCheck: .get
        }
    }
    
    var path: String {
        switch self {
        case .join: "/users/join"
        case .login: "/users/login"
        case .refresh: "/auth/refresh"
        case .withdraw: "/users/withdraw"
        case .profileCheck: "/users/me/profile"
        }
    }
    
    var header: [String : String] {
        switch self {
        case .join:
            [HTTPHeader.contentType.rawValue : HTTPHeader.json.rawValue,
             HTTPHeader.sesacKey.rawValue : APIKey.secretKey.rawValue]
        case .login:
            [HTTPHeader.contentType.rawValue : HTTPHeader.json.rawValue,
             HTTPHeader.sesacKey.rawValue : APIKey.secretKey.rawValue]
        case .refresh:
            [HTTPHeader.sesacKey.rawValue : APIKey.secretKey.rawValue,
             HTTPHeader.authorization.rawValue : UserDefaults.standard.string(forKey: "accessToken")!,
             HTTPHeader.refresh.rawValue : UserDefaults.standard.string(forKey: "refreshToken")!]
        case .withdraw:
            [HTTPHeader.sesacKey.rawValue : APIKey.secretKey.rawValue,
             HTTPHeader.authorization.rawValue : UserDefaults.standard.string(forKey: "accessToken")!]
        case .profileCheck:
            [HTTPHeader.sesacKey.rawValue : APIKey.secretKey.rawValue,
             HTTPHeader.authorization.rawValue : UserDefaults.standard.string(forKey: "accessToken")!]
        }
    }
    
    var parameters: String? {
        nil
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
    
    var body: Data? {
        switch self {
        case .login(let query):
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        case .join(query: let query):
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return try? encoder.encode(query)
        default: return nil
        }
    }
}
