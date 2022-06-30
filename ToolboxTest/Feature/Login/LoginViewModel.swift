//
//  LoginViewModel.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    private let client: LoginClient = {
        return LoginClient(configuration: ClientConfiguration(baseURL: Service.shared.url, httpHeaders: ["accept" : "application/json",
                                                                                                         "Content-Type" : "application/json"]))
    }()
    @Published var navigateToHome: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    func doLogin(){
        let request = LoginRequest(sub: "ToolboxMobileTest")
        client.login(request: request)
            .sink { error in
                print(error)
            } receiveValue: { response in
                DispatchQueue.main.async {
                    Service.shared.token = response.token
                    Service.shared.type = response.type
                    self.navigateToHome.toggle()
                }
            }
            .store(in: &cancellables)
    }
}
