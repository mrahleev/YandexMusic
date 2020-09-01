//
//  PassportRouter.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

enum PassportRouter {
    case start(login: String)
    case auth(trackId: String, password: String)
}

extension PassportRouter: APIRouter {

    var basePath: String? {
        return nil
    }

    var path: String {
        switch self {
        case .start(_):
            return "https://mobileproxy.passport.yandex.net/2/bundle/mobile/start/"
        case .auth(_, _):
            return "https://mobileproxy.passport.yandex.net/1/bundle/mobile/auth/password/"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .start(_):
            return .post
        case .auth(_, _):
            return .post
        }
    }

    var requestContentType: RequestContentType {
        switch self {
        case .start(_):
            return .formURLEncoded
        case .auth(_, _):
            return .formURLEncoded
        }
    }

    var urlParams: URLParameters? {
        switch self {
        case .start(_):
            return nil
        case .auth(_, _):
            return nil
        }
    }

    var bodyParams: BodyParameters? {
        switch self {
        case .start(let login):
            return ["client_id": Constants.API.clientId,
                    "client_secret": Constants.API.clientSecret,
                    "display_language": "en",
                    "login": login,
                    "x_token_client_id": Constants.API.xTokenClientId,
                    "x_token_client_secret": Constants.API.xTokenClientSecret]
        case .auth(let trackId, let password):
            return ["track_id": trackId,
                    "password": password,
            ]
        }
    }
}
