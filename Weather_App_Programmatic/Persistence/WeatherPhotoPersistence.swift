//
//  AnimePersistence.swift
//  AnimeListStarter
//
//  Created by C4Q on 10/9/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//
import Foundation
struct WeatherPhotoPersistenceHelper {
    static let manager = WeatherPhotoPersistenceHelper()
    
    func save(newPhoto: FavoritePhotosModel) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }
    
    func getPhotos() throws -> [FavoritePhotosModel] {
        return try persistenceHelper.getObjects()
    }
    
    func deleteFavorite(withMessage: Data) throws {
        do {
            let entries = try getPhotos()
            let newEntries = entries.filter { $0.imageData != withMessage}
            try persistenceHelper.replace(elements: newEntries)
        }
    }
    
    func editEntry(editEntry: FavoritePhotosModel, index: Int) throws {
        do {
            try persistenceHelper.update(updatedElement: editEntry, index: index)
        } catch {
            print(error)
        }
        
    }
    private let persistenceHelper = PersistenceHelper<FavoritePhotosModel>(fileName: "weatherPhoto.plist")
    
    private init() {}
}
