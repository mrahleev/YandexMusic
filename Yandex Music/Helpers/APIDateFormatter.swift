//
//  APIDateFormatter.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

final class APIDateFormatter: DateFormatter {
    static let shared = APIDateFormatter()

    func dateFromServerString(_ dateStr: String) -> Date? {
        /// Possible date strings:
        /// 2019-11-30T15:00:00
        /// 2018-05-20T15:00:00Z
        /// 2019-11-29T19:53:57.9328435+00:00

        let formats = ["yyyy-MM-dd'T'HH:mm:ss",
                       "yyyy-MM-dd'T'HH:mm:ssZ",
                       "yyyy-MM-dd'T'HH:mm:ss.SSSZ"]

        for format in formats {
            dateFormat = format

            if let date = date(from: dateStr) {
                return date
            }
        }

        return nil
    }
}
