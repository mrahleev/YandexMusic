//
//  User.swift
//  Yandex Music
//
//  Created by Maksim Rakhleyeu on 9/2/20.
//  Copyright © 2020 Maksim Rakhleyeu. All rights reserved.
//

import Foundation

struct User: Decodable {

    enum Gender: String, Decodable {
        case male = "m"
        case female = "f"
    }

    let public_id: String
    let uid: Int
    let firstname: String
    let lastname: String
    let cloud_token: String
    let birthday: String
    let has_password: Bool
    let has_music_subscription: Bool
    let has_plus: Bool
    let primary_alias_type: Int
    let x_token: String
    let display_name: String
    let access_token: String
    let gender: Gender
    let normalized_display_login: String
    let display_login: String
    let public_name: String
    let avatar_url: String
    let native_default_email: String
}

//    {
//        "status": "ok",
//        "access_token_expires_in": 31536000,
//        "public_id": "4p744z0u9ebcuk43qmde7dpmvg",
//        "uid": 231398308,
//        "firstname": "\u041c\u0430\u043a\u0441\u0438\u043c",
//        "lastname": "\u0420\u0430\u0445\u043b\u0435\u0435\u0432",
//        "x_token_expires_in": 31523633,
//        "cloud_token": "cl-8274860dc8dc43d98486ddc114da0f3f",
//        "birthday": "1993-08-31",
//        "has_password": true,
//        "has_music_subscription": true,
//        "has_plus": true,
//        "primary_alias_type": 1,
//        "x_token": "AgAAAAANytukAAAVs76F-BqWfkWGhc-5xm22EcQ",
//        "display_name": "mrahleev",
//        "access_token": "1.231398308.113758.1630529788.1598993788453.30962.k7dTBiQOroavWA7I.RSX78zhC_olzo5nU8Mw6YbmmncnC_NKfvNgubtaqya6dabm9BzdolzT_BjlAiihjzcnDdgF4AHIULN47iuFkVZmEeI_Mfdqndrzv.AMdjVVRKQSEfvaYFgeuMQg",
//        "gender": "m",
//        "normalized_display_login": "maximrachleew",
//        "x_token_issued_at": 1598993788,
//        "display_login": "maximrachleew",
//        "public_name": "mrahleev",
//        "avatar_url": "https://avatars.mds.yandex.net/get-yapic/25817/enc-20b1460d3c5e7b4c6aa84549ac6d2471aaf91133e9b12d477a3a7808196d02a3/normal",
//        "native_default_email": "maximrachleew@yandex.by"
//    }
