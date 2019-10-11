//
//  PhotoAPIClient.swift
//  Pixabay-Photos-Save-Local
//
//  Created by Mr Wonderful on 10/1/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

class PhotoAPIClient{
    
    static let shared = PhotoAPIClient()
    
    func getData(searchTerm:String, complitionHandler:@escaping (Result<[Hit],AppError>)->()){
        let urlString = "https://pixabay.com/api/?q=\(searchTerm.replacingOccurrences(of: " ", with: "+"))&key=13796584-2f2235b8d92a3da4a6b039cc9"
        
        guard let url = URL(string: urlString) else {
            complitionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result{
            case.failure(let error):
                complitionHandler(.failure(error))
            case .success(let data):
                
                do{
                    let photoData = try JSONDecoder().decode(Photos.self, from: data)
                    complitionHandler(.success(photoData.hits))
                }catch{
                    complitionHandler(.failure(.other(rawError: error)))
                }
            }
        }
    }
    
}
