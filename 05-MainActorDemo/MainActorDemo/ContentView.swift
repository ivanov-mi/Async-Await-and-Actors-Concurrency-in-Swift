//
//  ContentView.swift
//  MainActorDemo
//
//  Created by Martin Ivanov on 4/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var todoListVM = TodoListViewModel()
    
    var body: some View {
        List(todoListVM.todos, id: \.id) { todo in
            Text(todo.title)
        }.task {
            await todoListVM.populateTodos()
        }
    }
}

#Preview {
    ContentView()
}
