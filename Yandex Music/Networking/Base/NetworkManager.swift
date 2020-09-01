//
//  NetworkManager.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

typealias GenericResult<T: Decodable> = Result<T, Error>
typealias Completion<T: Decodable> = (GenericResult<T>) -> Void

final class NetworkManager {
    private let urlSession: URLSession

    init() {
        // let configuration = URLSessionConfiguration()
        // configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        urlSession = URLSession.shared
    }

    // MARK: -

    func perform<T: Decodable>(request: URLRequestConvertible, completion: @escaping Completion<T>) {

        do {
            let urlRequest = try request.asURLRequest()

            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                } else if let data = data {
                    do {
                        let decoder = JSONResponseDecoder.decoder()
                        let object = try decoder.decode(T.self, from: data)
                        
                        DispatchQueue.main.async {
                            completion(.success(object))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            }.resume()

        } catch {
            completion(.failure(error))
        }
    }
}
