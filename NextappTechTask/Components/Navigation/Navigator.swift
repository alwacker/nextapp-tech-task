//
//  Navigator.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import UIKit

class Navigator {
    static var rootViewController: UIViewController? {
        if let window = UIApplication.shared.delegate?.window {
            return window?.rootViewController
        }
        return nil
    }
    
    static func getRootNavigationViewController(rootController: UIViewController) -> UINavigationController {
        let rootViewController = Navigator.rootViewController
        if let rootNavigationController = rootViewController as? NavigationViewController {
            return rootNavigationController
        } else {
            let navigationController = NavigationViewController(rootViewController: rootController)
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.isOpaque = true
            return navigationController
        }
    }
    
    static func showModalViewController(
        _ vc: UIViewController,
        inNavigationController: Bool,
        animated: Bool) {
        let root = Navigator.rootViewController
        vc.modalPresentationStyle = .fullScreen
        root?.present(vc, animated: animated)
    }
}
