//
//  VideoPlayerSettingsTableDataSource.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/25/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import UIKit

extension VideoPlayerSettingsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trackTypes(of: viewModel.sections[section]).count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch viewModel.sections[section] {
        case .audio:
            return "Audio"
        case .subtitle:
            return "Subtitles"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoPlayerSettingsTableViewController.classString, for: indexPath)
        
        let trackType = viewModel.sections[indexPath.section]
        cell.textLabel?.text = viewModel.trackTypes(of: trackType)[indexPath.row]
        cell.accessoryType = viewModel.isSelected(for: indexPath) ? .checkmark : .none
        
        return cell
    }

}
