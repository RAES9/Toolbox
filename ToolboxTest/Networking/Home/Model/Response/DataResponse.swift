//
//  DataResponse.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation

public typealias DataResponse = [Carrousel]

public struct Carrousel: Codable, Hashable{
    var title: String
    var type: String
    var items: [Items]
}

public struct Items: Codable, Hashable{
    var title: String
    var imageUrl: String
    var videoUrl: String?
    var description: String
}
