//
//  Constants.swift
//  RandomQuoteAndImages
//
//  Created by Martin Ivanov on 3/11/25.
//

import Foundation

struct Constants {
    
    struct Urls {
        
        static func getRandomImageUrl() -> URL? {
            return URL(string: "https://picsum.photos/200/300?uuid=\(UUID().uuidString)")
        }
        
        static let randomQuoteUrl: URL? = URL(string: "http://api.quotable.io/random")
        
    }
}
