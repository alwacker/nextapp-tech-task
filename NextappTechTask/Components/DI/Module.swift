//
//  Module.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import Swinject
import SwinjectAutoregistration

public protocol Module {
    init(assembler: Assembler)
    func loaded()
}

extension Module {
    public func loaded() {
        //NOP
    }
}

public class ModuleRegistrationContext {
    fileprivate var assemblies = [Assembly]()
    fileprivate var resolves = [(Assembler) -> ()]()
    fileprivate var modules = [Module]()
    
    public func register<T: Module>(_ module: T.Type) {
        assemblies.append(ModuleAssembly(module: module))
        resolves.append { assembler in
            let module = assembler.resolver.resolve(T.self)!
            self.modules.append(module)
        }
    }
}

public extension Assembler {
    func withModules(_ register: (_ context: ModuleRegistrationContext) -> ()) -> Assembler {
        let context = ModuleRegistrationContext()
        register(context)
        let assembler = Assembler(context.assemblies, parent: self).registerSelf()
        context.resolves.forEach {
            $0(assembler)
        }
        context.modules.forEach {
            $0.loaded()
        }
        return assembler
    }
}

public class ModuleAssembly<T: Module>: Assembly {
    let module: T.Type
    init(module: T.Type) {
        self.module = module
    }
    public func assemble(container: Container) {
        container
            .autoregister(module.self, initializer: module.init)
            .inObjectScope(.container)
    }
}

