//
//  Webservice.swift
//  RandomQuoteAndImages
//
//  Created by Martin Ivanov on 3/11/25.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidImageId(Int)
    case decodingError
}

class Webservice {
    
    func getRandomImages(ids: [Int]) async throws -> [RandomImage] {
        
        var randomImages: [RandomImage] = []
        
        try await withThrowingTaskGroup(of: (Int, RandomImage?).self) { group in
            
            for id in ids {
                group.addTask { [weak self] in
                    return (id, try await self?.getRandomImage(id: id))
                }
            }
            
            for try await (_, randomImage) in group {
                if let randomImage {
                    randomImages.append(randomImage)
                }
            }
        }
        
        return randomImages
    }
    
    func getRandomImage(id: Int) async throws -> RandomImage {
        
        guard let url = Constants.Urls.getRandomImageUrl(),
              let randomQuoteUrl = Constants.Urls.randomQuoteUrl else {
                   throw NetworkError.badUrl
        }
        
        async let (imageData, _) = URLSession.shared.data(from: url)
        async let (randomQuoteData, _) = URLSession.shared.data(from: randomQuoteUrl)
        
        guard let quote = try? JSONDecoder().decode(Quote.self, from: try await randomQuoteData) else {
            throw NetworkError.decodingError
        }
        
        return RandomImage(image: try await imageData, quote: quote)
    }
}
