//
//  JSONResponseDecoder.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

enum DecoderDateFormat: String {
    /// 2019-11-30T15:00:00
    case yyyyMMddThhmmss = "yyyy-MM-ddThh:mm:ss"
}

class JSONResponseDecoder: JSONDecoder {
    private let dateFormatter = DateFormatter()

    class func decoder() -> JSONDecoder {
        let decoder = JSONDecoder()

        decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            if let date = APIDateFormatter.shared.dateFromServerString(dateStr) {
                return date
            } else {
                let debugDescription = "Cannot decode date string \(dateStr)"
                throw DecodingError.dataCorruptedError(in: container, debugDescription: debugDescription)
            }
        }

        return decoder
    }
}
