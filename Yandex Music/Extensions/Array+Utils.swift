//
//  Array+Utils.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

extension Array {
    
    subscript(safe index: Int) -> Element? {
        if indices.contains(index) {
            return self[index]
        } else {
            return nil
        }
    }
}
