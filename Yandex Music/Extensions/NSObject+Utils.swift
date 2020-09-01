//
//  NSObject+Utils.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/1/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

extension NSObject {

    static var className: String {
        return NSStringFromClass(self).removingModuleNamePrefix()
    }

    var className: String {
        return type(of: self).className
    }
}

#if DEBUG
// MARK: - FOR DEBUG PURPOSES ONLY
extension NSObject {

    var __methods: [Selector] {
        var methodCount: UInt32 = 0
        guard let methodList = class_copyMethodList(type(of: self), &methodCount),
            methodCount != 0 else {
                return []
        }
        return (0 ..< Int(methodCount)).compactMap { method_getName(methodList[$0]) }
    }
}
#endif
