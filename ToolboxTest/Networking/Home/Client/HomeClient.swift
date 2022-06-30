//
//  HomeClient.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation
import Combine

public protocol HomeProvider {
    func retriveData() -> AnyPublisher<DataResponse, Error>
}

public final class HomeClient: RestClient, HomeProvider {
    public func retriveData() -> AnyPublisher<DataResponse, Error> {
        self.request(resource: HomeResource.retriveData, type: DataResponse.self, errorType: DataResponse.self)
    }
}
