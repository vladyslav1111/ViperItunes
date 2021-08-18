//
//  SearchQueryProvider.swift
//  Search
//
//  Created by Vlad Tkachuk on 15.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import Common

extension AppConfigEndPoint {
    static let searchEndpoint = AppConfigEndPoint("searchEndpoint")
}

protocol SearchQueryProviderProtocol {
    func getMoviesSearchQuery(searchText: String) -> String
}

class SearchQueryProvider: SearchQueryProviderProtocol {
    private let config: AppConfigDelegate
    init(config: AppConfigDelegate) {
        self.config = config
    }
    
    func getMoviesSearchQuery(searchText: String) -> String {
        let params = ["term": searchText, "media": "movie", "limit": "15"]
        return config.getQuery(with: ConfigurationQuery.itunes(endpoint: .searchEndpoint), params: params)
    }
}
