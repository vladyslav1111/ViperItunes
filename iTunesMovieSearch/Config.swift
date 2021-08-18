//
//  Config.swift
//  iTunesMovieSearch
//
//  Created by Vlad Tkachuk on 15.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import Common

struct AppConfigKey {
    static let domains = "Domains"
    static let endpoints = "Endpoints"
}

public class Config: AppConfigDelegate {
    public func getQuery(with configQuery: ConfigurationQueryProtocol) -> String {
        let dictionary = getDictionaryForConfigName(configName: "Endpoints", bundle: Bundle.main)
        guard let domainsDict = dictionary[AppConfigKey.domains] as? [String: String],
            let domain = domainsDict[configQuery.domainKey],
            let endpointsDict = dictionary[AppConfigKey.endpoints] as? [String: String],
            let endpoint = endpointsDict[configQuery.endpointKey] else { return "" }
        return domain + endpoint
    }
    
    public func getQuery(with configQuery: ConfigurationQueryProtocol, params: [String: String]) -> String {
        let query = params.map { "\($0)=\($1)" }.joined(separator: "&")
        return getQuery(with: configQuery) + "?" + query
    }
    
    private func getDictionaryForConfigName(configName: String, bundle: Bundle) -> [String: Any] {
        guard let path = bundle.path(forResource: configName, ofType: "plist") else {
            return [:]
        }
        
        let url = URL(fileURLWithPath: path)
        
        guard let data = NSDictionary(contentsOf: url) as? [String: Any] else {
            return [:]
        }

        return data
    }
}
