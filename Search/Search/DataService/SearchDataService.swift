//
//  SearchDataService.swift
//  Search
//
//  Created by Vlad Tkachuk on 15.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import Common
import Networking

public protocol SearchDataServiceProtocol {
    func configure(with config: AppConfigDelegate)
    func searchMovies(withText searchText: String, completionHandler: @escaping (SearchResponse?) -> Void)
}

public class SearchDataService: SearchDataServiceProtocol {
    public static let shared = SearchDataService()
    private var networkingService: NetworkingProtocol!
    private var config: AppConfigDelegate!
    private var queryProvider: SearchQueryProviderProtocol!
    
    private init() {}
    
    public func configure(with config: AppConfigDelegate) {
        self.config = config
        networkingService = NetworkingDataService.shared
        queryProvider = SearchQueryProvider(config: config)
    }
    
    public func searchMovies(withText searchText: String, completionHandler: @escaping (SearchResponse?) -> Void) {
        let guery = queryProvider.getMoviesSearchQuery(searchText: searchText)
        networkingService.get(query: guery, params: nil) { (result: Result<SearchResponse, Error>) in
            switch result {
            case .success(let searchResponse):
                completionHandler(searchResponse)
            case .failure(_):
                completionHandler(nil)
            }
        }
    }
    
}
