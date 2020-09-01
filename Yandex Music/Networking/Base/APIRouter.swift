//
//  APIRouter.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

typealias URLParameters = [String: String]
typealias BodyParameters = [String: Encodable]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum RequestContentType: String {
    case formURLEncoded = "application/x-www-form-urlencoded"
}

protocol APIRouter: URLRequestConvertible {
    var basePath: String? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var requestContentType: RequestContentType { get }
    var urlParams: URLParameters? { get }
    var bodyParams: BodyParameters? { get }
}

extension APIRouter {

    func asURLRequest() throws -> URLRequest {

        var baseURL: URL?

        if let basePath = basePath {
            baseURL = URL(string: basePath)
            baseURL?.appendPathComponent(path)
        } else {
            baseURL = URL(string: path)
        }
        guard var url = baseURL else {
            throw URLError(.badURL)
        }

        if let urlParams = urlParams {
            url.appendURLParams(urlParams)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.addValue(requestContentType.rawValue, forHTTPHeaderField: "Content-Type")

        if let bodyParams = bodyParams {
            if requestContentType == .formURLEncoded {
                let data = bodyParams.toQueryString().data(using: .utf8)
                urlRequest.httpBody = data
            } else {
                let data = try JSONSerialization.data(withJSONObject: bodyParams)
                urlRequest.httpBody = data
            }
        }

        return urlRequest
    }
}
