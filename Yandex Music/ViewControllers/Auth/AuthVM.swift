//
//  AuthVM.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/2/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

protocol AuthVMProtocol {    
    func enterUserName(_ userName: String, completion: @escaping (Error?) -> Void)
    func enterPassword(_ password: String, completion: @escaping Completion<User>)
}

final class AuthVM {
    private lazy var passportService: AuthServiceProtocol = AuthService()
    private var trackId: String?
    private var user: User?
}

extension AuthVM: AuthVMProtocol {

    func enterUserName(_ userName: String, completion: @escaping (Error?) -> Void) {
        passportService.start(login: userName) { (result) in
            switch result {
            case .success(let trackId):
                self.trackId = trackId
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }

    func enterPassword(_ password: String, completion: @escaping Completion<User>) {
        guard let trackId = trackId else {
            // TODO: (Maksim) Return error that there is no trackId
            return
        }

        passportService.auth(trackId: trackId, password: password, completion: completion)
    }
}
