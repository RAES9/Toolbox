//
//  LoginRequest.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation

public struct LoginRequest: Codable {
    var sub: String
}

extension LoginRequest {
    func decoder() -> [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}
