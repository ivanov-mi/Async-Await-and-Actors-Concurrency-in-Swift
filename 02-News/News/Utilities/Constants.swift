//
//  Constants.swift
//  News
//
//  Created by Martin Ivanov on 3/5/25.
//

import Foundation

struct Constants {
    
    struct Urls {
        
        private static let apiKey = "db48ec8b5d2d470d893e936aff1bb1c2"
        static let sources: URL? = URL(string: "https://newsapi.org/v2/sources?apiKey=\(apiKey)")
        
        static func topHeadlines(by source: String) -> URL? {
            return URL(string: "https://newsapi.org/v2/top-headlines?sources=\(source)&apiKey=\(apiKey)")
        }
    }
}
