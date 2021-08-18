//
//  TrackPageViewController.swift
//  TrackPage
//
//  Created by Vlad Tkachuk on 17.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Common

protocol TrackPageViewProtocol: class {
    func setTitle(_ title: String)
    func setAuthor(_ author: String)
    func setupMusicPlayer(with imageUrl: URL, previewUrl: URL)
    func setupViewPlayer(with url: URL)
    func refresh()
}

public class TrackPageViewController: UIViewController {
    @IBOutlet weak var playerContentView: UIView!
    @IBOutlet weak var currentTimeSilder: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    private var trackImageView: UIImageView?
    
    let playImage = UIImage(named: "play", in: Bundle(for: TrackPageViewController.self), with: nil)
    let pauseImage = UIImage(named: "pause", in: Bundle(for: TrackPageViewController.self), with: nil)
    
    var presenter: TrackPagePresentable!
    let player: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
        
    }
    
    @IBAction func handleCurrentTimeSlider(_ sender: Any) {
        let percentage = currentTimeSilder.value
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeUpSeconds = Float64(percentage) * durationInSeconds
        let time = CMTimeMakeWithSeconds(seekTimeUpSeconds, preferredTimescale: 1)
        player.seek(to: time)
    }
    
    @IBAction func handleVolumeSlider(_ sender: Any) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(pauseImage, for: .normal)
        } else {
            player.pause()
            playPauseButton.setImage(playImage, for: .normal)
        }
    }
    
    @IBAction func playPrevButtonTapped(_ sender: Any) {
        presenter.playPreviousTrack()
    }
    
    @IBAction func playNextButtonTapped(_ sender: Any) {
        presenter.playNextTrack()
    }
    
    private func playTrack(previewUrl: URL) {
        let playerItem = AVPlayerItem(url: previewUrl)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    private func observePlayerCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) {[weak self] (time) in
            self?.currentTimeLabel.text = time.toDisplayString()
            let durationTime = self?.player.currentItem?.duration
            let currentDurationString = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString()
            self?.durationLabel.text = "-\(currentDurationString)"
            self?.updateCurrentTimeSlider()
        }
    }
    
    private func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds/durationSeconds
        self.currentTimeSilder.value = Float(percentage)
    }
}

extension TrackPageViewController: TrackPageViewProtocol {
    func refresh() {
        presenter.configureView()
    }
    
    func setTitle(_ title: String) {
        trackTitleLabel.text = title
    }
    
    func setAuthor(_ author: String) {
        authorTitleLabel.text = author
    }
    
    func setupMusicPlayer(with imageUrl: URL, previewUrl: URL) {
        trackImageView?.loadImage(from: imageUrl)
    }
    
    func setupViewPlayer(with url: URL) {
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = playerContentView.bounds
        playerContentView.layer.addSublayer(playerLayer)
        playTrack(previewUrl: url)
        observePlayerCurrentTime()
    }
}
