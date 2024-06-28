//
//  StreamingOverviewModel.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/24/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import Foundation

struct StreamingOverviewModel {
    
    private let streams: [VideoStream] = StreamManager.providers
    
    var streamCount: Int {
        return streams.count
    }
    
    func stream(at indexPath: IndexPath) -> VideoStream? {
        guard indexPath.row < streams.count else { return nil }
        return streams[indexPath.row]
    }
}
