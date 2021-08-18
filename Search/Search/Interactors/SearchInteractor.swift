//
//  SearchInteractor.swift
//  Search
//
//  Created by Vlad Tkachuk on 16.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import Common

protocol SearchInteractorProtocol {
    func configure(with config: AppConfigDelegate)
    func makeSearch(withText searchText: String)
    func getTrack(at index: Int) -> Track?
    func nullifySearchResult()
    var numberOfTracks: Int? { get }
    func getTrackName(at index: Int) -> String?
    func getArtistName(at index: Int) -> String?
    func getImage(at index: Int) -> String?
    func clickTrack(at index: Int)
}

class SearchInteractor: SearchInteractorProtocol {
    weak var presenter: SearchPresenterProtocol?
    var dataService: SearchDataServiceProtocol!
    private var searchResponse: SearchResponse?
    private var clicketTrackIndex: Int!
    
    var numberOfTracks: Int? {
        searchResponse?.resultCount
    }
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure(with config: AppConfigDelegate) {
        dataService = SearchDataService.shared
        dataService.configure(with: config)
    }
    
    func makeSearch(withText searchText: String) {
        dataService.searchMovies(withText: searchText) { [weak self] (searchResponse) in
            self?.searchResponse = searchResponse
            self?.presenter?.showSearchResult()
        }
    }
    
    func getTrack(at index: Int) -> Track? {
        searchResponse?.results[index]
    }
    
    func nullifySearchResult() {
        searchResponse = nil
    }
    
    func getTrackName(at index: Int) -> String? {
        let track = getTrack(at: index)
        return track?.trackName
    }
    
    func getArtistName(at index: Int) -> String? {
        let track = getTrack(at: index)
        return track?.artistName
    }
    
    func getImage(at index: Int) -> String? {
        let track = getTrack(at: index)
        return track?.artworkUrl100
    }
    
    func clickTrack(at index: Int) {
        clicketTrackIndex = index
    }
}

extension SearchInteractor: TrackSwitchDelegate {
    public func moveBackForPreviousTrack() -> Track? {
        guard let tracks = searchResponse?.results else { return nil }
        if clicketTrackIndex - 1 == -1 {
            clicketTrackIndex = tracks.count - 1
        } else {
            clicketTrackIndex -= 1
        }
        return tracks[clicketTrackIndex]
    }
    
    public func moveForwardForPreviousTrack() -> Track? {
        guard let tracks = searchResponse?.results else { return nil }
        if clicketTrackIndex + 1 == tracks.count {
            clicketTrackIndex = 0
        } else {
            clicketTrackIndex += 1
        }
        return tracks[clicketTrackIndex]
    }
}
