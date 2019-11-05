//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Christy Hicks on 11/5/19.
//  Copyright © 2019 Knight Night. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults {
    let results: [SearchResult]
}
