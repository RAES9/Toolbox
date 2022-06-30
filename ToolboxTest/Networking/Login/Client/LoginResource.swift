//
//  LoginResource.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation

enum LoginResource: Resource {
    case login
    
    var resource: (method: HTTPMethod, route: String) {
        switch self {
        case .login:
            return (.POST, "/v1/mobile/auth")
        }
    }
}
