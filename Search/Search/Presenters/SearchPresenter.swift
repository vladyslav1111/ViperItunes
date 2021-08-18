//
//  SearchPresenter.swift
//  Search
//
//  Created by Vlad Tkachuk on 16.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import Common

protocol SearchPresentable: class {
    var numberOfItems: Int { get }
    func cancelSearch()
    func trackTapped(at index: Int)
    func configure(with config: AppConfigDelegate)
    func submitSearch(_ searchText: String)
    func getTrackViewModel(forIndex index: Int) -> TrackViewModel
    var trackSwitchDelegate: TrackSwitchDelegate { get }
}

protocol SearchPresenterProtocol: class {
    func showSearchResult()
}

class SearchPresenter: SearchPresenterProtocol {
    var router: SearchRouterProtocol!
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorProtocol!
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
    
    func showSearchResult() {
        view?.refresh()
    }
}

extension SearchPresenter: SearchPresentable {
    var trackSwitchDelegate: TrackSwitchDelegate {
        interactor as! TrackSwitchDelegate
    }
    
    var numberOfItems: Int {
        interactor.numberOfTracks ?? 0
    }
    
    func getTrackViewModel(forIndex index: Int) -> TrackViewModel {
        return TrackViewModel(trackName: interactor.getTrackName(at: index) ?? "",
                              artistName: interactor.getArtistName(at: index) ?? "",
                              imageUrlString: interactor.getImage(at: index) ?? "")
    }
    
    func trackTapped(at index: Int) {
        guard let track = interactor.getTrack(at: index) else { return }
        interactor.clickTrack(at: index)
        router.showTrackPage(with: track)
    }
    
    func configure(with config: AppConfigDelegate) {
        interactor.configure(with: config)
    }
    
    func submitSearch(_ searchText: String) {
        interactor.makeSearch(withText: searchText)
    }
    
    func cancelSearch() {
        interactor.nullifySearchResult()
        view?.refresh()
    }
}
