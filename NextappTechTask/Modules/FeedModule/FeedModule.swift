//
//  FeedModule.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import Swinject

class FeedModule: Module {
    private let assembler: Assembler
    
    required init(assembler: Assembler) {
        self.assembler = assembler.with(assemblies: FeedModuleAssembly())
    }
    
    func showFeedModule(with transitionHandler: TransitionHandler) -> UIViewController {
        return assembler
            .with(assemblies: FeedViewAssembly())
            .with(globals: transitionHandler)
            .resolver
            .resolve(FeedViewController.self)!
    }
}
