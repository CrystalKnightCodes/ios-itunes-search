//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Christy Hicks on 11/5/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation

class SearchResultController {
    let baseURL = URL(string: "https://itunes.apple.com")!
    
    var searchResults: [SearchResult] = []
    
    func performSearch(searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
    
    guard let requestURL = urlComponents?.url else {
        print("Request URL is nil")
        completion()
        return
    }
    
        // Do I need to create an HTTPMethod enum for this one and add the commented code?
    let request = URLRequest(url: requestURL)
        // request.httpMethod = HTTPMethod.get.rawValue
    
        URLSession.shared.dataTask(with: request) { data, _, error in
        if let error = error {
            print("Error fetching data: \(error)")
            return
        }
        guard let data = data else {
            print("No data returned from data task.")
            return
        }
        
        let jsonDecoder = JSONDecoder ()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let performSearch = try jsonDecoder.decode(SearchResult.self, from: data)
            self.searchResults.append(performSearch.self)
        } catch {
            print("Unable to decode data into object of type \(ResultType.self): \(error)")
        }
            completion()
    }.resume()
}
}
