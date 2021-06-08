//
//  HeroicModel.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 24.05.2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let heroicModel = try? newJSONDecoder().decode(HeroicModel.self, from: jsonData)

import Foundation

// MARK: - HeroicModel
struct HeroicModel: Codable {
    let count: Int
    let next: String?
    let results: [HeroicResult]
}

// MARK: - Result
struct HeroicResult: Codable,Equatable {
    static func == (lhs: HeroicResult, rhs: HeroicResult) -> Bool {
        true
    }
    
    let id: Int
    let name: String
    let metacritic: Int?
    let released: String?
    let background_image: String?
    let playtime: Int
    let parent_platforms: [ParentPlatform]?
    let genres: [Genre]?

}
struct ParentPlatform: Codable {
    let platform : Platform
}
struct Platform: Codable,Equatable {
    let name: String
}
struct Genre: Codable {
    let name: String
}



