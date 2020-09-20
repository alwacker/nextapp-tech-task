//
//  TransitionHandler.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import UIKit

public protocol TransitionHandler {
    func push(controller: UIViewController, animated: Bool)
    func modal(controller: UIViewController, animated: Bool)
}

extension UIViewController: TransitionHandler {
    public func modal(controller: UIViewController, animated: Bool) {
        present(controller, animated: animated, completion: nil)
    }
    
    public func push(controller: UIViewController, animated: Bool) {
        navigationController?.pushViewController(controller, animated: animated)
    }
}
