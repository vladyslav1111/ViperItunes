//
//  TrackSwitchDelegate.swift
//  Common
//
//  Created by Vlad Tkachuk on 17.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import Foundation

public protocol TrackSwitchDelegate: class {
    func moveBackForPreviousTrack() -> Track?
    func moveForwardForPreviousTrack() -> Track?
}
