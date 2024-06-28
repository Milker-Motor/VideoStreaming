//
//  VideoPlayer.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/25/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import UIKit
import AVFoundation

class TableViewController: UITableViewController {
    let viewModel: ViewControllerModel
    
    init(viewModel: ViewControllerModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
    }
}

extension TableViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return viewModel.objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = viewModel.title(at: indexPath)
        return cell
    }
}

struct ViewControllerModel {
    let objects = ["example 1", "example 2", "example 3", "example 4"]
    let cellIdentifier = "cell"
    
    func testFunc(par1: Int, par2: Bool? = false) {
        print("\(par1) \(String(describing: par2))")
    }
    
    func title(at indexPath: IndexPath) -> String {
        testFunc(par1: 100)
        testFunc(par1: 200, par2: true)
        
        if indexPath.row > objects.count + 1 {
            assertionFailure()
            return ""
        }
        return objects[indexPath.row]
    }
}


class VideoPlayer {
    let viewModel: VideoPlayerViewModel
    
    let menu: DefaultPlayerMenu
    let video: DefaultPlayerVideo
    
    lazy var alertCotnroller: UIAlertController = {
        let alertController = UIAlertController(title: "title", message: "message", preferredStyle: .alert)
        return alertController
    }()
    
    weak var owner: UIViewController?
    
    init(viewModel: VideoPlayerViewModel, menu: DefaultPlayerMenu, video: DefaultPlayerVideo) {
        self.viewModel = viewModel
        self.menu = menu
        self.video = video
        
        menu.delegate = self
        menu.viewModel = viewModel
    }
    
    func dismiss() {
        viewModel.player.pause()
        video.dismiss()
    }
}

extension VideoPlayer: VideoPlayerMenuDelegate {
    func play() {
        viewModel.player.play()
    }

    func pause() {
        viewModel.player.pause()
    }
    
    func sliderChanged(seconds: Float) {
        let player = viewModel.player
        let targetTime: CMTime = CMTimeMake(value: Int64(seconds), timescale: 1)
        player.seek(to: targetTime)
    }

    func settingsPressed() {
        let videoPlayerSettingsTableViewModel = VideoPlayerSettingsTableViewModel(viewModel.player.currentItem)
        let videoPlayerSettingsTableViewController = VideoPlayerSettingsTableViewController(videoPlayerSettingsTableViewModel)

        videoPlayerSettingsTableViewController.delegate = self
        
        guard let presentationController = AlwaysPresentationPopover.configurePresentation(for: videoPlayerSettingsTableViewController) else { return }
        presentationController.sourceView = menu.settingsButton
        presentationController.sourceRect = menu.settingsButton.bounds
        presentationController.permittedArrowDirections = [.down]
        owner?.present(videoPlayerSettingsTableViewController, animated: true)
    }
}

extension VideoPlayer: VideoPlayerSettingsDelegate {
    func selected(type: AVPlayerItem.TrackType, name: String, controller: UIViewController?) {
        controller?.dismiss(animated: true)
        _ = viewModel.player.currentItem?.select(type: type, name: name)
    }
    
    func deleted(type: AVPlayerItem.TrackType, controller: UIViewController?) {
        controller?.dismiss(animated: true)
        viewModel.player.currentItem?.delete(type: type)
    }
}
