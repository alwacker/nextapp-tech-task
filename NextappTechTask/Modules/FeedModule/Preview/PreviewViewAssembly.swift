//
//  PreviewViewAssembly.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 20/09/2020.
//

import Swinject
import SwinjectAutoregistration

internal class PreviewViewAssembly: Assembly {
    func assemble(container: Container) {
        container
            .autoregister(PreviewViewModel.self, initializer: PreviewViewModel.init)
        container
            .autoregister(PreviewViewController.self, initializer: PreviewViewController.init)
        container
            .autoregister(FeedRouter.Context.self, initializer: FeedRouter.Context.init)
    }
}
