//
//  FeedViewAssembly.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Swinject
import SwinjectAutoregistration

internal class FeedViewAssembly: Assembly {
    func assemble(container: Container) {
        container
            .autoregister(FeedViewController.self, initializer: FeedViewController.init)
        container
            .autoregister(FeedViewModel.self, initializer: FeedViewModel.init)
        container
            .autoregister(FeedRouter.self, initializer: FeedRouter.init)
    }
}
