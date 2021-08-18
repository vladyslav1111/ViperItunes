//
//  TrackTableViewCell.swift
//  Search
//
//  Created by Vlad Tkachuk on 16.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import UIKit
import Common

struct TrackViewModel {
    let trackName: String
    let artistName: String
    let imageUrlString: String?
}

class TrackTableViewCell: UITableViewCell {
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var addTrackButton: UIButton!
    
    func configure(with viewModel: TrackViewModel) {
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        guard let url = URL(string: viewModel.imageUrlString ?? "") else { return }
        trackImageView.loadImage(from: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.trackImageView.image = nil
    }
    
}
