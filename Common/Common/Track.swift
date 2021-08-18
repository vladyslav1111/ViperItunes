//
//  Track.swift
//  TrackPage
//
//  Created by Vlad Tkachuk on 17.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation

public enum TrackKind: String, Codable {
    case music = "song"
    case movie = "feature-movie"
}

public struct Track: Codable {
    public let trackName: String
    public let artistName: String
    public let collectionName: String?
    public let artworkUrl100: String?
    public let previewUrl: String?
    public let kind: TrackKind
}
