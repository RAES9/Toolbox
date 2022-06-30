//
//  Service.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation

struct Service {
    static var shared: Service = Service()
    let url: String = "https://echo-serv.tbxnet.com"
    var token: String = ""
    var type: String = ""
}
