//
//  AuthError.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/2/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

enum AuthError: String, LocalizedError {
    case accountNotFound = "account.not_found"
    case accountAuthPassed = "account.auth_passed"
    case passwordNotMatched = "password.not_matched"
    case unknown

    // MARK:

    init(code: String) {
        self = AuthError(rawValue: code) ?? .unknown
    }

    var errorDescription: String? {
        switch self {
        case .accountNotFound:
            return "No account found with specified username."
        case .accountAuthPassed:
            return "Authentication with specified `trackId` already passed."
        case .passwordNotMatched:
            return "Wrong password."
        case .unknown:
            return "Something went wrong. Try again."
        }
    }
}
