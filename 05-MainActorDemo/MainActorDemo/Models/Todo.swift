//
//  Todo.swift
//  MainActorDemo
//
//  Created by Martin Ivanov on 4/4/25.
//

import Foundation

struct Todo: Decodable {
    let id: Int
    let title: String
    let completed: Bool
}
