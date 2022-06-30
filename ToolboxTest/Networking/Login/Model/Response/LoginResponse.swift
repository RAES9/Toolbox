//
//  LoginResponse.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation

public struct LoginResponse: Codable {
    var sub: String
    var token: String
    var type: String
}
