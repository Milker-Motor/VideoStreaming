//
//  VideoPlayerSettingsTableViewModel.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/25/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import Foundation
import AVFoundation

struct VideoPlayerSettingsTableViewModel {
    private let playerItem: AVPlayerItem?
    
    let indexSubtitleOff = 0
    
    lazy var sections: [AVPlayerItem.TrackType] = {
        var sections = [AVPlayerItem.TrackType]()
        if self.trackTypes(of: .audio).count > 0 {
            sections.append(.audio)
        }
        if self.trackTypes(of: .subtitle).count > 0 {
            sections.append(.subtitle)
        }
        return sections
    }()
    
    init(_ playerItem: AVPlayerItem?) {
        self.playerItem = playerItem
    }
    
    func trackTypes(of type: AVPlayerItem.TrackType) -> [String] {
        switch type {
        case .audio:
            return playerItem?.tracks(type: type) ?? []
        case .subtitle:
            var tracks = (playerItem?.tracks(type: type) ?? [])
            tracks.insert("Off", at: indexSubtitleOff)
            return tracks
        }
    }
    
    func selectedIndex(of type: AVPlayerItem.TrackType) -> Int? {
        guard let selectedIndex = playerItem?.selected(type: type) else { return nil }
        return trackTypes(of: type).firstIndex(of: selectedIndex)
    }
    
    mutating func isSelected(for indexPath: IndexPath) -> Bool {
        let trackType = sections[indexPath.section]
        return selectedIndex(of: trackType) == indexPath.row ||
            (trackType == .subtitle && indexPath.row == indexSubtitleOff && selectedIndex(of: trackType) == nil)
    }
}
