//
//  NewsSourceListViewModel.swift
//  News
//
//  Created by Martin Ivanov on 3/5/25.
//

import Foundation

@MainActor
class NewsSourceListViewModel: ObservableObject {
    
    @Published var newsSources: [NewsSourceViewModel] = []
    
    func getSources() async {
        
        do {
            let newSources = try await Webservice().fetchSources(url: Constants.Urls.sources)
            self.newsSources = newSources.map(NewsSourceViewModel.init)
        } catch {
            print(error)
        }
    }
}

struct NewsSourceViewModel {
    
    fileprivate var newsSource: NewsSource
    
    var id: String {
        newsSource.id
    }
    
    var name: String {
        newsSource.name
    }
    
    var description: String {
        newsSource.description
    }
    
    static var `default`: NewsSourceViewModel {
        let newsSource = NewsSource(id: "abc-news", name: "ABC News", description: "This is ABC news")
        return NewsSourceViewModel(newsSource: newsSource)
    }
}
