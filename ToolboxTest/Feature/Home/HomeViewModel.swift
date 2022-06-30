//
//  HomeViewModel.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation
import Combine
import AVKit

class HomeViewModel: ObservableObject {
    private let client: HomeClient = {
        return HomeClient(configuration: ClientConfiguration(baseURL: Service.shared.url, httpHeaders: ["accept" : "application/json",
                                                                                                        "Content-Type" : "application/json",
                                                                                                        "authorization" : "\(Service.shared.type) \(Service.shared.token)"]))
    }()
    @Published var data: DataResponse = []
    @Published var showVideo: Bool = false
    @Published var player: AVPlayer = AVPlayer()
    private var cancellables = Set<AnyCancellable>()
    
    func retriveData(){
        client.retriveData()
            .sink { error in
                print(error)
            } receiveValue: { response in
                DispatchQueue.main.async {
                    self.data = response
                }
            }
            .store(in: &cancellables)
    }
}
