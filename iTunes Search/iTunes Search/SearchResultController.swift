//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Christy Hicks on 11/5/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        let resultTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        urlComponents?.queryItems = [searchTermQueryItem, resultTypeQueryItem]
        
        
        guard let requestURL = urlComponents?.url else {
            print("Request URL is nil")
            completion()
            return
        }
    
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        // print(request.url)
        URLSession.shared.dataTask(with: request) { data, _, error in
        if let error = error {
            print("Error fetching data: \(error)")
            completion()
            return
        }
        guard let data = data else {
            print("No data returned from data task.")
            completion()
            return
        }
        
        let jsonDecoder = JSONDecoder ()
        //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let performSearch = try jsonDecoder.decode(SearchResults.self, from: data)
            self.searchResults = performSearch.results
            
        } catch {
            print("Unable to decode data into object of type \(ResultType.self): \(error)")
        }
        completion()
            
    }.resume()
}
}
