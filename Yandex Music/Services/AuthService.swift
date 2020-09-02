//
//  AuthService.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

protocol AuthServiceProtocol {
    func start(login: String, completion: @escaping Completion<String>)
    func auth(trackId: String, password: String, completion: @escaping Completion<User>)
}

final class AuthService: AuthServiceProtocol {
    private let networkManager = NetworkManager()

    // MARK:

    func start(login: String, completion: @escaping Completion<String>) {
        let request = PassportRouter.start(login: login)

        struct StartResponseModel: Decodable {
            let can_authorize: Bool?
            let status: String
            let track_id: String
            let auth_methods: [String]?
            let errors: [String]?
        }

        networkManager.perform(request: request) { (result: GenericResult<StartResponseModel>) in
            switch result {

            case .success(let startResponseModel):

                if startResponseModel.can_authorize == true,
                    startResponseModel.status == "ok",
                    startResponseModel.auth_methods?.contains("password") == true {
                    completion(.success(startResponseModel.track_id))
                } else if startResponseModel.status == "error",
                    let errorString = startResponseModel.errors?.first {
                    completion(.failure(AuthError(code: errorString)))
                } else {
                    completion(.failure(AuthError.unknown))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func auth(trackId: String, password: String, completion: @escaping Completion<User>) {

        let request = PassportRouter.auth(trackId: trackId, password: password)

        networkManager.perform(request: request) { (result: GenericResult<User>) in
            switch result {
            case .success(let userModel):
                completion(.success(userModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}
