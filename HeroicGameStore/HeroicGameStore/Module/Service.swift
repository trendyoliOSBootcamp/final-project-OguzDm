//
//  Service.swift
//  HeroicGameStore
//
//  Created by Oguz Demırhan on 24.05.2021.
//

import Foundation

class Service {
    static let shared = Service()
    var baseURL = "https://api.rawg.io/api/games?key=3bcebfccf85d42b2aa562a5f52139179&page=1"
    func fetchGames(next: String,completionHandler : @escaping (Result<HeroicModel,Error>) -> Void ) {
        let requestURL = next
        guard let apiURL = URL(string: requestURL) else {return}
        let task = URLSession.shared.dataTask(with: apiURL) { data, resp, err in
            guard let data = data else {return}
            do {
                let gamesModel = try JSONDecoder().decode(HeroicModel.self, from: data)
                completionHandler(.success(gamesModel))
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func fetchPlatforms(completionHandler: @escaping(Result<PlatformModel,Error>) -> Void) {
        guard let requestURL = URL(string: "https://api.rawg.io/api/platforms/lists/parents?key=3bcebfccf85d42b2aa562a5f52139179") else {return}
        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in
            guard let data = data else {return}
            do {
                let platformModel = try JSONDecoder().decode(PlatformModel.self, from: data)
                completionHandler(.success(platformModel))
            }
            catch(let error){
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func fetchFilteredData(next: String,completionHandler : @escaping (Result<HeroicModel,Error>) -> Void ) {
        let requestURL = next
        guard let apiURL = URL(string: requestURL) else {return}
        let task = URLSession.shared.dataTask(with: apiURL) { data, resp, err in
            guard let data = data else {return}
            do {
                let gamesModel = try JSONDecoder().decode(HeroicModel.self, from: data)
                completionHandler(.success(gamesModel))
            }
            catch(let error) {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func fetchGameWithID(id: Int, completionHandler: @escaping(Result<HeroicResult,Error>) -> Void) {
        let requestURL = "https://api.rawg.io/api/games/\(id)?key=3bcebfccf85d42b2aa562a5f52139179" // to-do make constants for all url
        guard let apiURL = URL(string: requestURL) else {return}
        let task = URLSession.shared.dataTask(with: apiURL) { data, resp, err in
            guard let data = data else {return}
            do{
                let gameDetailModel = try JSONDecoder().decode(HeroicResult.self, from: data)
                completionHandler(.success(gameDetailModel))
            }
            catch(let error){
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func fetchGamesWithSearch(query: String, next: String,completionHandler : @escaping (Result<HeroicModel,Error>) -> Void){
        let requestURL = "\(next)&search=\(query)"
        guard let apiURL = URL(string: requestURL) else {return}
        let task = URLSession.shared.dataTask(with: apiURL) { data, resp, err in
            guard let data = data else {return}
            do{
                let searchModel = try JSONDecoder().decode(HeroicModel.self, from: data)
                completionHandler(.success(searchModel))
            }
            catch(let error){
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func fetchGameDetail(id: Int, completionHandler: @escaping(Result<GameDetailModel,Error>) -> Void) {
        let requestURL = "https://api.rawg.io/api/games/\(id)?key=3bcebfccf85d42b2aa562a5f52139179" // to-do make constants for all url
        guard let apiURL = URL(string: requestURL) else {return}
        let task = URLSession.shared.dataTask(with: apiURL) { data, resp, err in
            guard let data = data else {return}
            do{
                let gameDetailModel = try JSONDecoder().decode(GameDetailModel.self, from: data)
                completionHandler(.success(gameDetailModel))
            }
            catch(let error){
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
