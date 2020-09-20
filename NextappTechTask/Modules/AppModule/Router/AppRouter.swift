//
//  AppRouter.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import RxSwift
import Swinject
import UIKit

public class AppRouter: NSObject {
    private let resolver: Resolver
    private let disposeBag = DisposeBag()

    init(resolver: Resolver) {
        self.resolver = resolver
        super.init()
    }
    
    func initialize() -> UIViewController {
        let module = resolver.resolve(FeedModule.self)!
        let vc = module.showFeedModule(with: self)
        let root = NavigationViewController(rootViewController: vc)
        return root
    }
}
