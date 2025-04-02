//
//  ContentView.swift
//  RandomQuoteAndImages
//
//  Created by Martin Ivanov on 3/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var randomImageListViewModel = RandomImageListViewModel()
    
    var body: some View {
        NavigationView {
            List(randomImageListViewModel.randomImages) { randomImage in
                
                HStack {
                    randomImage.image.map {
                        Image(uiImage: $0)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    Text(randomImage.quote)
                }
            }.task {
                await randomImageListViewModel.getRandomImages(ids: Array(100...120))
            }
            .navigationTitle("Random Images with Quotes")
            .navigationBarItems(trailing: Button(action: {
                Task {
                    await randomImageListViewModel.getRandomImages(ids: Array(100...120))
                }
            }, label: {
                Image(systemName: "arrow.clockwise.circle")
            }))
        }
    }
}

#Preview {
    ContentView()
}
