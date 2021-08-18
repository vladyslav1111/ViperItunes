//
//  TrackPagePresenter.swift
//  TrackPage
//
//  Created by Vlad Tkachuk on 17.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation

protocol TrackPagePresentable: class {
    func configureView()
    func playPreviousTrack()
    func playNextTrack()
}

protocol TrackPagePresenterProtocol: class {
    func showTrack()
}

class TrackPagePresenter: TrackPagePresenterProtocol {
    weak var view: TrackPageViewProtocol?
    var interactor: TrackPageInteractorProtocol!
    var router: TrackPageRouterProtocol!
    
    init(with view: TrackPageViewProtocol) {
        self.view = view
    }
    
    func showTrack() {
        view?.refresh()
    }
}

extension TrackPagePresenter: TrackPagePresentable {
    func configureView() {
        view?.setTitle(interactor.trackTitle)
        view?.setAuthor(interactor.authorName)
        
        switch interactor.kind {
        case .music:
            guard let imageUrl = URL(string: interactor.image ?? ""),
                  let previewUrl = URL(string: interactor.preview ?? "")
                else { return }
            view?.setupMusicPlayer(with: imageUrl, previewUrl: previewUrl)
        case .movie:
            guard let url = URL(string: interactor.preview ?? "") else { return }
            view?.setupViewPlayer(with: url)
        }
    }
    
    func playPreviousTrack() {
        interactor.loadPreviousTrack()
    }
    
    func playNextTrack() {
        interactor.loadNextTrack()
    }
}
