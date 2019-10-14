//
//  AnimePersistence.swift
//  AnimeListStarter
//
//  Created by C4Q on 10/9/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

struct WeatherPhotoPersistenceHelper {
    static let manager = WeatherPhotoPersistenceHelper()
    
    func save(newPhoto: FavoritePhotosModel) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }
    
    func getPhotos() throws -> [FavoritePhotosModel] {
        return try persistenceHelper.getObjects()
    }
    
    private let persistenceHelper = PersistenceHelper<FavoritePhotosModel>(fileName: "weatherPhoto.plist")
    
    private init() {}
}
