//
//  TrackPageConfigurator.swift
//  TrackPage
//
//  Created by Vlad Tkachuk on 17.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation
import Common
protocol TrackPageConfigutatorProtocol {
    func configure(with controller: TrackPageViewController)
    func initiateInteractor(with track: Track, switchDelegate: TrackSwitchDelegate)
}

public class TrackPageConfigurator: TrackPageConfigutatorProtocol {
    private var interactor: TrackPageInteractor!
    
    public init() {}
    
    public func configure(with controller: TrackPageViewController) {
        let presenter = TrackPagePresenter(with: controller)
        interactor = TrackPageInteractor(with: presenter)
        let router = TrackPageRouter(viewController: controller)
        
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        controller.presenter = presenter
    }
    
    public func initiateInteractor(with track: Track, switchDelegate: TrackSwitchDelegate) {
        interactor.configure(with: track)
        interactor.switchDelegate = switchDelegate
    }
}
