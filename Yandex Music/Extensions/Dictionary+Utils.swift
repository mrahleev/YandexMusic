//
//  Dictionary+Utils.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

extension Dictionary {

    func toQueryString() -> String {
        return map { (key, value) -> String in
            return "\(key)=\(value)"
        }.joined(separator: "&")
    }
}
