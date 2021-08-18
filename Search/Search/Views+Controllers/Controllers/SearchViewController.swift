//
//  SearchViewController.swift
//  Search
//
//  Created by Vlad Tkachuk on 16.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import UIKit
import Common

protocol SearchViewProtocol: class {
    func refresh()
}

public class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SearchPresentable!
    var configurator: SearchConfiguratorProtocol = SearchConfigurator()
    
    let searchController = UISearchController(searchResultsController: nil)
    var timer: Timer?
    private var config: AppConfigDelegate!
    private lazy var footerView = FooterView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configure(with: config)
        setupTableView()
        setupSearchBar()
    }

    public func configure(with config: AppConfigDelegate) {
        self.config = config
    }
    
    private func setupTableView() {
        tableView.tableFooterView = footerView
        tableView.register(TrackTableViewCell.self)
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
}

extension SearchViewController: SearchViewProtocol {
    func refresh() {
        DispatchQueue.main.async {
            self.footerView.hideLoader()
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(TrackTableViewCell.self, for: indexPath)
        let viewModel = presenter.getTrackViewModel(forIndex: indexPath.row)
        cell.configure(with: viewModel)
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.trackTapped(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter some search term above..."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.presenter.numberOfItems > 0 ? 0 : 250
    }
}

extension SearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {[weak self] (_) in
            self?.footerView.showLoader()
            self?.presenter.submitSearch(searchText)
        })
    }
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.cancelSearch()
    }
}
