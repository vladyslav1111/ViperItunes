//
//  TableView+Cells+Extensions.swift
//  Common
//
//  Created by Vlad Tkachuk on 16.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import UIKit

public protocol NibLoadable {
    static func getNib(with bundle: Bundle) -> UINib
    static var identifier: String { get }
}

public extension NibLoadable {
    static func getNib(with bundle: Bundle) -> UINib {
        UINib(nibName: identifier, bundle: bundle)
    }

    static var identifier: String {
        String(describing: self)
    }
}

public extension UINib {
    convenience init<T>(_: T.Type) {
        self.init(nibName: String(describing: T.self), bundle: Bundle(for: T.self as! AnyClass))
    }
}

extension UITableViewCell: NibLoadable {}
extension UITableViewHeaderFooterView: NibLoadable {}

public extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.getNib(with: Bundle(for: T.self)), forCellReuseIdentifier: T.identifier)
    }

    func register<T: UITableViewHeaderFooterView>(_: T.Type) {
        register(T.getNib(with: Bundle(for: T.self)), forHeaderFooterViewReuseIdentifier: T.identifier)
    }

    func dequeue<T: UITableViewCell>(_: T.Type) -> T {
        dequeueReusableCell(withIdentifier: T.identifier) as! T
    }

    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }

    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
    }
}
