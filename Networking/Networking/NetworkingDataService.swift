//
//  NetworkDataService.swift
//  Networking
//
//  Created by Vlad Tkachuk on 15.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import Common
import Alamofire

public class NetworkingDataService: NetworkingProtocol {
    
    public static let shared = NetworkingDataService()
    private var config: AppConfigDelegate!
    
    private init() {}
    
    public func configure(with config: AppConfigDelegate) {
        self.config = config
    }
    
    public func get<T>(query: String, params: [String: String]?,
                       completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        AF.request(query, method: .get,
                   parameters: params,
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .validate()
            .responseDecodable { (response: DataResponse<T, AFError>) in
            let result = response.mapError { $0 as Error }.result
            completionHandler(result)
        }
    }
    
    
}
