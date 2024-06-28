//
//  StreamingOverviewDataSource.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/24/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import UIKit

extension StreamingOverviewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.streamCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StreamingOverviewController.classString, for: indexPath)
        guard let stream = viewModel.stream(at: indexPath) else {
            assertionFailure()
            return UITableViewCell()
        }
        cell.textLabel?.text = stream.name
        
        return cell
    }
}
