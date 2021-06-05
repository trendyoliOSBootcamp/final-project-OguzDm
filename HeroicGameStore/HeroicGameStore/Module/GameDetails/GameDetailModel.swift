//
//  GameDetailModel.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 27.05.2021.
//

import Foundation

struct GameDetailModel: Codable {
    let id: Int
    let name: String
    let metacritic: Int
    let website: String
    let background_image: String
    let description_raw: String
    let released: String
    let playtime: Int
    let genres: [GameGenre]
    let publishers: [Publisher]
    let reddit_url: String
}
struct GameGenre: Codable {
    let name: String
}
struct Publisher: Codable {
    let name: String
}
