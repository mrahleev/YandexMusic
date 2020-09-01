//
//  String+Utils.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

public extension String {

    /// Removes module prefix
    /// Ex. YandexMusic.AppDelegate -> AppDelegate
    internal func removingModuleNamePrefix() -> String {
        let lastPart = split(separator: ".").last
        return lastPart != nil ? String(lastPart!) : self
    }
}
