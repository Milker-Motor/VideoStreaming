//
//  DefaultPlayerMenu.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/25/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoPlayerMenuDelegate: class {
    func play()
    func pause()
    func sliderChanged(seconds: Float)
    func settingsPressed()
}

final class DefaultPlayerMenu: UIView {
    
    // MARK: -
    // MARK: public properties
    
    var viewModel: VideoPlayerViewModel? {
        didSet {
            configureProgressSlider()
            bind()
        }
    }

    @IBOutlet weak var playPauseButton: UIButton! {
        didSet {
            round(button: playPauseButton)
        }
    }
    
    @IBOutlet weak var settingsButton: UIButton! {
        didSet {
            round(button: settingsButton)
        }
    }
    
    @IBOutlet weak var progressSlider: UISlider!
    
    weak var delegate: VideoPlayerMenuDelegate?
    
    // MARK: -
    // MARK: private properties
    
    private func round(button: UIButton) {
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.2
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.clipsToBounds = true
    }
    
    private enum ActionState {
        case play
        case pause
    }
    
    private var sliderRefreshTimer: Timer?
    
    @objc dynamic var currentDuration: Double {
        return CMTimeGetSeconds(self.viewModel?.player.currentTime() ?? .zero)
    }
    
    @objc dynamic var totalDuration: Double {
        return CMTimeGetSeconds(self.viewModel?.player.currentItem?.asset.duration ?? .zero)
    }
    
    // MARK: -
    // MARK: actions
    
    @IBAction private func playPausePressed() {
        if self.viewModel?.player.timeControlStatus == .playing {
            delegate?.pause()
        } else {
            delegate?.play()
        }
    }
    
    @IBAction func settingsButtonPressed() {
        delegate?.settingsPressed()
    }
    
    @IBAction func progressSliderChanged(_ playbackSlider: UISlider) {
        delegate?.sliderChanged(seconds: playbackSlider.value)
    }
    
    // MARK: -
    // MARK: private functions
    private var timeControlStatusObservation: NSKeyValueObservation?
    func bind() {
            timeControlStatusObservation = self.viewModel?.player.observe(\.timeControlStatus, options: [.new, .old], changeHandler: { [weak self] (player, _) in
                if player.timeControlStatus == .playing {
                    self?.playPauseButton.setImage(UIImage(assetIdentifier: .pause), for: .normal)
                    self?.startSliderRefreshTimer()
                } else {
                    self?.playPauseButton.setImage(UIImage(assetIdentifier: .play), for: .normal)
                    self?.terminateSliderRefreshTimer()
                }
            })
    }
    
    private func configureProgressSlider() {
        progressSlider.minimumValue = 0
        progressSlider.maximumValue = Float(totalDuration)
        progressSlider.isContinuous = true
        progressSlider.tintColor = .gray
    }
    
    private func startSliderRefreshTimer() {
        sliderRefreshTimer = Timer.scheduledTimer(timeInterval: 1,
                                                  target: self,
                                                  selector: #selector(timerIsTriggered),
                                                  userInfo: nil,
                                                  repeats: true)
    }
    
    private func terminateSliderRefreshTimer() {
        sliderRefreshTimer?.invalidate()
        sliderRefreshTimer = nil
    }
    
    @objc private func timerIsTriggered() {
        progressSlider.value = Float(currentDuration)
    }
}
