//
//  UserDefaults+Extensions.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 1.06.2021.
//

import Foundation

extension UserDefaults {
    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
