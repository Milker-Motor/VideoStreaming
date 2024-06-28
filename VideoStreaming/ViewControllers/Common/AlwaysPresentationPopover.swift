//
//  AlwaysPresentationPopover.swift
//  VideoStreaming
//
//  Created by Oleksii Lytvynov-Bohdanov on 7/26/19.
//  Copyright © 2019 Oleksii. All rights reserved.
//

import UIKit

class AlwaysPresentationPopover: NSObject, UIPopoverPresentationControllerDelegate {
    private static let sharedInstance = AlwaysPresentationPopover()
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    static func configurePresentation(for controller : UIViewController) -> UIPopoverPresentationController? {
        controller.modalPresentationStyle = .popover
        guard let presentationController = controller.presentationController as? UIPopoverPresentationController else { return nil }
        presentationController.delegate = AlwaysPresentationPopover.sharedInstance
        return presentationController
    }
}
