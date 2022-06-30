//
//  HomeResource.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation

enum HomeResource: Resource {
    case retriveData
    
    var resource: (method: HTTPMethod, route: String) {
        switch self {
        case .retriveData:
            return (.GET, "/v1/mobile/data")
        }
    }
}
