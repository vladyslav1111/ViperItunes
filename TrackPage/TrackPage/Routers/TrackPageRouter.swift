//
//  TrackPageRouter.swift
//  TrackPage
//
//  Created by Vlad Tkachuk on 17.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation

protocol TrackPageRouterProtocol {
    
}

class TrackPageRouter: TrackPageRouterProtocol {
    weak var viewController: TrackPageViewController?
    init(viewController: TrackPageViewController) {
        self.viewController = viewController
    }
}
