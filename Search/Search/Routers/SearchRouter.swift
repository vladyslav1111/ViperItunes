//
//  SearchRouter.swift
//  Search
//
//  Created by Vlad Tkachuk on 16.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import TrackPage
import Common

protocol SearchRouterProtocol {
    func showTrackPage(with selectedTrack: Track)
}

class SearchRouter: SearchRouterProtocol {
    weak var viewController: SearchViewController?
    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
    
    func showTrackPage(with selectedTrack: Track) {
        let trackPageViewController: TrackPageViewController = TrackPageViewController.loadFromStoryboard()
        let trackConfigurator = TrackPageConfigurator()
        trackConfigurator.configure(with: trackPageViewController)
        trackConfigurator.initiateInteractor(with: selectedTrack, switchDelegate: viewController!.presenter.trackSwitchDelegate)
        viewController?.present(trackPageViewController, animated: true, completion: nil)
    }
}
