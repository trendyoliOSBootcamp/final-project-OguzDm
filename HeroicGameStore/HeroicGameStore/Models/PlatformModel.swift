//
//  PlatformModel.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 25.05.2021.
//

import Foundation


struct PlatformModel: Codable {
    let results: [PlatformResults]
}
struct PlatformResults: Codable,Equatable {
    let name: String
}
