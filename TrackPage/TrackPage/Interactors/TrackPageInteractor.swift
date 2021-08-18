//
//  TrackPageInteractor.swift
//  TrackPage
//
//  Created by Vlad Tkachuk on 17.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import Common

protocol TrackPageInteractorProtocol {
    var trackTitle: String { get }
    var authorName: String { get }
    var image: String? { get }
    var preview: String? { get }
    var kind: TrackKind { get }
    func loadPreviousTrack()
    func loadNextTrack()
}

class TrackPageInteractor: TrackPageInteractorProtocol {
    weak var presenter: TrackPagePresenterProtocol?
    weak var switchDelegate: TrackSwitchDelegate?
    private var currentTrack: Track!
    
    init(with presenter: TrackPagePresenterProtocol) {
        self.presenter = presenter
    }
    
    func configure(with track: Track) {
        currentTrack = track
    }
    
    var trackTitle: String {
        currentTrack.trackName
    }
    
    var authorName: String {
        currentTrack.artistName
    }
    
    var image: String? {
        currentTrack.artworkUrl100
    }
    
    var preview: String? {
        currentTrack.previewUrl
    }
    
    var kind: TrackKind {
        currentTrack.kind
    }
    
    func loadPreviousTrack() {
        currentTrack = switchDelegate?.moveBackForPreviousTrack()
        presenter?.showTrack()
    }
    
    func loadNextTrack() {
        currentTrack = switchDelegate?.moveForwardForPreviousTrack()
        presenter?.showTrack()
    }
}
