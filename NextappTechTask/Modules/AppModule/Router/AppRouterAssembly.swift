//
//  AppRouterAssembly.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Swinject
import SwinjectAutoregistration

internal class AppRouterAssembly: Assembly {
    func assemble(container: Container) {
        container
            .autoregister(AppRouter.self, initializer: AppRouter.init)
            .inObjectScope(.container)
    }
}
