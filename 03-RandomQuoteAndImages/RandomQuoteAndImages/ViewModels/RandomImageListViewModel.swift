//
//  RandomImageListViewModel.swift
//  RandomQuoteAndImages
//
//  Created by Martin Ivanov on 3/11/25.
//

import UIKit

@MainActor
class RandomImageListViewModel: ObservableObject {
    
    @Published var randomImages: [RandomImageViewModel] = []
    
    func getRandomImages(ids: [Int]) async {
        do {
            
            let webservice = Webservice()
            randomImages = []
            
            try await withThrowingTaskGroup(of: (Int, RandomImage).self) { group in
                
                for id in ids {
                    group.addTask {
                        return (id, try await webservice.getRandomImage(id: id))
                    }
                }
                
                for try await (_, randomImage) in group {
                    randomImages.append(RandomImageViewModel(randomImage: randomImage))
                }
            }
            
        } catch {
            print(error)
        }
    }
}

struct RandomImageViewModel: Identifiable {
    
    let id = UUID()
    let randomImage: RandomImage
    
    var image: UIImage? {
        UIImage(data: randomImage.image)
    }
    
    var quote: String {
        randomImage.quote.content
    }
}
