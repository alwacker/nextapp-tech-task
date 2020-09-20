//
//  AppModule.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import Swinject

public class AppModule: Module {
    internal let assembler: Assembler
    
    public required init(assembler: Assembler) {
        self.assembler = assembler
            .with(globals: Bundle.main)
    }
    
    public lazy var router: AppRouter = {
        return self.assembler
            .with(assemblies: AppRouterAssembly())
            .resolver
            .resolve(AppRouter.self)!
    }()
}
