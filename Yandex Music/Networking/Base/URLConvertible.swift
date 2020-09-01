//
//  URLConvertible.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}
