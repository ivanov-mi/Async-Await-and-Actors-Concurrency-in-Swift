//
//  Webservice.swift
//  News
//
//  Created by Martin Ivanov on 3/5/25.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidData
    case decodingError
}

class Webservice {
    
    func fetchSources(url: URL?) async throws -> [NewsSource] {
        
        guard let url else {
            throw NetworkError.badUrl
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.invalidData
        }
        
        guard let newsSourceResponse = try? JSONDecoder().decode(NewsSourceResponse.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return newsSourceResponse.sources
    }
    
    func fetchNewsAsync(sourceId: String, url: URL?) async throws -> [NewsArticle] {
        
        try await withCheckedThrowingContinuation { continuation in
            fetchNews(sourceId: sourceId, url: url) { result in
                switch result {
                case .success(let newsArticles):
                    continuation.resume(returning: newsArticles)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func fetchNews(sourceId: String, url: URL?, completion: @escaping (Result<[NewsArticle], NetworkError>) -> Void) {
        
        guard let url = url else {
            completion(.failure(.badUrl))
            return
        }
            
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            let newsArticleResponse = try? JSONDecoder().decode(NewsArticleResponse.self, from: data)
            completion(.success(newsArticleResponse?.articles ?? []))
            
        }.resume()
        
    }
}
