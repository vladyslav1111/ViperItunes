//
//  NetworkingProtocol.swift
//  Networking
//
//  Created by Vlad Tkachuk on 15.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import Common

public protocol NetworkingProtocol {
    func configure(with config: AppConfigDelegate)
    func get<T: Decodable>(query: String,
                           params: [String: String]?,
                           completionHandler: @escaping (Result<T, Error>) -> Void)
}
