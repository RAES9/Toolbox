//
//  RestClient.swift
//  ToolboxTest
//
//  Created by Tribal on 30/06/22.
//

import Foundation

import Combine
import Foundation

open class RestClient {
    private let baseURL: String
    private let headers: HTTPHeaders
    
    public init(configuration: ClientConfiguration) {
        baseURL = configuration.baseURL
        headers = configuration.httpHeaders
    }
    
    public func request<T: Decodable, U :Decodable>(resource: Resource,
                                                    parameters: [String: Any]? = nil,
                                                    headers: HTTPHeaders? = nil,
                                                    type: T.Type,
                                                    errorType: U.Type) -> AnyPublisher<T, Error> {
        let fullURLString = baseURL + resource.resource.route
        
        guard let url = URL(string: fullURLString) else {
            return Fail(error: NetworkingError.invalidRequestError("Invalid URL: \(fullURLString)")).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = resource.resource.method.rawValue
        
        self.headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if resource.resource.method != .GET,
         let parameters = parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        print("endpoint:", url)
        print("method:", urlRequest.httpMethod ?? String())
        let headersRequestString = String(describing: urlRequest.allHTTPHeaderFields)
        let jsonString = "request:\n" + headersRequestString.debugDescription + "\n" + (parameters?.debugDescription ?? String())
        print(jsonString)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError({ error -> NetworkingError in
                .unexpectedError(error)
            })
            .tryMap({ (data, response) -> (data: Data, response: URLResponse) in
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw NetworkingError.invalidResponse
                }
                print("RESPONSE", String(data: data, encoding: .utf8) ?? "{}")
                switch urlResponse.statusCode {
                case 401:
                    throw NetworkingError.unauthorized
                case 400, 402...599:
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(errorType, from: data)
                    throw NetworkingError.apiError(urlResponse.statusCode, error: apiError)
                default:
                    break
                }
                
                return (data, response)
            })
            .map(\.data)
            .tryMap({ data -> T in
                let decoder = JSONDecoder()
                print("RESPONSE", String(data: data, encoding: .utf8) ?? "{}")
                do {
                    return try decoder.decode(T.self, from: data)
                } catch {
                    let message = "Failed parsing object: \(String(describing: T.self))"
                    
                    throw NetworkingError.parsingError(error, message)
                }
            })
            .eraseToAnyPublisher()
    }
}

//MARK: - Config

public protocol Resource {
    var resource: (method: HTTPMethod, route: String) { get }
}

public typealias HTTPHeaders = [String: String]

public struct ClientConfiguration {
    let baseURL: String
    let httpHeaders: HTTPHeaders
    
    public init(baseURL: String, httpHeaders: HTTPHeaders) {
        self.baseURL = baseURL
        self.httpHeaders = httpHeaders
    }
}

public enum NetworkingError: Error {
    case apiError(Int, error: Decodable)
    case invalidRequestError(String)
    case invalidResponse
    case parsingError(Error, String)
    case unauthorized
    case unexpectedError(Error)
}

//MARK: - Methods

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

//MARK: - Enconder
struct JSON {
    static let encoder = JSONEncoder()
}
