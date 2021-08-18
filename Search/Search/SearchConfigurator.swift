//
//  SearchConfigurator.swift
//  Search
//
//  Created by Vlad Tkachuk on 16.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation

public protocol SearchConfiguratorProtocol {
    func configure(with controller: SearchViewController)
}

public class SearchConfigurator: SearchConfiguratorProtocol {
    public func configure(with controller: SearchViewController) {
        let presenter = SearchPresenter(view: controller)
        let interactor = SearchInteractor(presenter: presenter)
        let router = SearchRouter(viewController: controller)
        presenter.interactor = interactor
        presenter.router = router
        controller.presenter = presenter
    }
}
