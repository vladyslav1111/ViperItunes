//
//  SearchResponse.swift
//  Search
//
//  Created by Vlad Tkachuk on 16.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import Common

public struct SearchResponse: Codable {
   public  var resultCount: Int
    public var results: [Track]
}
