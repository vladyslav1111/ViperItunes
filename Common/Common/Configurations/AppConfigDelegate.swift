//
//  AppConfigDelegate.swift
//  Common
//
//  Created by Vlad Tkachuk on 15.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation

public protocol AppConfigDelegate: AnyObject {
    func getQuery(with configQuery: ConfigurationQueryProtocol) -> String
    func getQuery(with configQuery: ConfigurationQueryProtocol, params: [String: String]) -> String
}
