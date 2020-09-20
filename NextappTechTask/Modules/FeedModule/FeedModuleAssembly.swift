//
//  FeedModuleAssembly.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Swinject
import SwinjectAutoregistration

internal class FeedModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(FeedService.self, initializer: FeedService.init)
    }
}
