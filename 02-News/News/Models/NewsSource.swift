//
//  NewsSource.swift
//  News
//
//  Created by Martin Ivanov on 3/5/25.
//

import Foundation

struct NewsSourceResponse: Decodable {
    let sources: [NewsSource]
}

struct NewsSource: Decodable {
    let id: String
    let name: String
    let description: String
}
