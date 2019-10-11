//
//  AnimeListAPIClient.swift
//  AnimeList
//
//  Created by Mr Wonderful on 10/10/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//
import Foundation


struct AnimeAPIClient {
    private init() {}
    static let shared = AnimeAPIClient()
    
    func getAnimeFrom(searchWord: String, completionHandler: @escaping (Result<[Anime], AppError>) -> ()) {
        let urlStr = "https://api.jikan.moe/v3/search/anime?q=\(searchWord)"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(AppError.badURL))
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
            case .success(let data):
                do {
                    let animeArr = try AnimeResultsWrapper.getAnimeFromData(data: data)
                    completionHandler(.success(animeArr))
                }
                catch {
                    completionHandler(.failure(.other(rawError: error)))
                }
            }
        }
    }
    
}



