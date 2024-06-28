//
//  VideoPlayerSettingsTableViewController.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/25/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoPlayerSettingsDelegate: class {
    func selected(type: AVPlayerItem.TrackType, name: String, controller: UIViewController?)
    func deleted(type: AVPlayerItem.TrackType, controller: UIViewController?)
}

class VideoPlayerSettingsTableViewController: UITableViewController {
    
    var viewModel: VideoPlayerSettingsTableViewModel
    weak var delegate: VideoPlayerSettingsDelegate?
    
    init(_ viewModel: VideoPlayerSettingsTableViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        registerCells()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: VideoPlayerSettingsTableViewController.classString)
    }
}
