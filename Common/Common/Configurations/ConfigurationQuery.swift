//
//  ConfigurationQuery.swift
//  Common
//
//  Created by Vlad Tkachuk on 15.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation

public enum AppConfigDomainType {
    case itunes
    case other(name: String)

    var domainKey: String {
        switch self {
        case .itunes:
            return "itunes"
        case let .other(name):
            return name
        }
    }
}

public protocol ConfigurationQueryProtocol {
    var domainType: AppConfigDomainType { get }
    var endpoint: AppConfigEndPoint { get }

    var domainKey: String { get }
    var endpointKey: String { get }

    init(domainType: AppConfigDomainType, endpoint: AppConfigEndPoint)
}

public struct ConfigurationQuery: ConfigurationQueryProtocol {
    public let domainType: AppConfigDomainType
    public let endpoint: AppConfigEndPoint

    public var domainKey: String {
        domainType.domainKey
    }

    public var endpointKey: String {
        endpoint.rawValue
    }

    public init(domainType: AppConfigDomainType, endpoint: AppConfigEndPoint) {
        self.domainType = domainType
        self.endpoint = endpoint
    }

    public static func itunes(endpoint: AppConfigEndPoint) -> ConfigurationQueryProtocol {
        ConfigurationQuery(domainType: .itunes, endpoint: endpoint)
    }
}
