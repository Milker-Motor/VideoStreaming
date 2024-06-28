//
//  AVPlayerItem+Tracks.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/25/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import AVFoundation

extension AVPlayerItem {
    enum TrackType {
        case audio
        case subtitle
        
        fileprivate func characteristic(item: AVPlayerItem) -> AVMediaSelectionGroup? {
            let mediaCharacteristic: AVMediaCharacteristic = self == .audio ? .audible : .legible
            if item.asset.availableMediaCharacteristicsWithMediaSelectionOptions.contains(mediaCharacteristic) {
                return item.asset.mediaSelectionGroup(forMediaCharacteristic: mediaCharacteristic)
            }
            return nil
        }
    }
    
    func tracks(type: TrackType) -> [String] {
        
        guard let characteristic = type.characteristic(item: self) else { return [] }
        switch type {
        case .audio:
            return characteristic.options
                .map { $0.displayName }
        case .subtitle:
            return characteristic.options
                .filter {
                    guard let propertyList = $0.propertyList() as? [String: Any] else { return false }
                    // I think it could be improved
                    return propertyList.keys.contains("MediaSelectionOptionsDisplaysNonForcedSubtitles")
                }
                .map { $0.displayName }
        }
    }
    
    func selected(type: TrackType) -> String? {
        guard let group = type.characteristic(item: self) else { return nil }
        let selected = currentMediaSelection.selectedMediaOption(in: group)
        
        return selected?.displayName
        
    }
    
    func select(type: TrackType, name: String) -> Bool {
        guard let group = type.characteristic(item: self),
            let matched = group.options.filter({ $0.displayName == name }).first else { return false }
        
        self.select(matched, in: group)
        return true
    }
    
    func delete(type: TrackType) {
        guard let group = type.characteristic(item: self) else { return }
        self.select(nil, in: group)
    }
}
