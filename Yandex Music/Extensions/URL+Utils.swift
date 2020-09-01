//
//  URL+Utils.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

extension URL {

    mutating func appendURLParams(_ params: [String: String]) {
        var urlComps = URLComponents(url: self, resolvingAgainstBaseURL: false)

        urlComps?.queryItems = params.compactMap { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        self = urlComps?.url ?? self
    }
}
