//
//  StreamingOverviewDelegate.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/24/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import UIKit

extension StreamingOverviewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let stream = viewModel.stream(at: indexPath) else { return }
        let streamingDetailViewController = StreamingDetailViewController(videoStream: stream)
        self.navigationController?.pushViewController(streamingDetailViewController, animated: true)
    }
}
