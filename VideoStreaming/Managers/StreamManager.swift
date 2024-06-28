//
//  StreamManager.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/24/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import Foundation

struct StreamManager {
    // could be imroved with returning blocks success / error or reactive signal
    static var providers: [VideoStream] {
        let name = "HLS stream"
        let url = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_16x9/bipbop_16x9_variant.m3u8")
        let hlsStream = VideoStream(name: name, url: url)
        return [hlsStream]
    }
}
