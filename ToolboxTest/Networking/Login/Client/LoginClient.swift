//
//  LoginClient.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation
import Combine

public protocol LoginProvider {
    func login(request: LoginRequest) -> AnyPublisher<LoginResponse, Error>
}

public final class LoginClient: RestClient, LoginProvider {
    public func login(request: LoginRequest) -> AnyPublisher<LoginResponse, Error> {
        self.request(resource: LoginResource.login, parameters: request.decoder(), type: LoginResponse.self, errorType: LoginResponse.self)
    }
}
