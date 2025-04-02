//
//  RandomImage.swift
//  RandomQuoteAndImages
//
//  Created by Martin Ivanov on 3/11/25.
//

import Foundation

struct RandomImage: Decodable {
    let image: Data
    let quote: Quote
}

struct Quote: Decodable {
    let content: String
}
