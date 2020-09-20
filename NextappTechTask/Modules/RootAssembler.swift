//
//  RootAssembler.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Swinject
import SwinjectAutoregistration

public class RootAssembler: NSObject {
    public static let instance = RootAssembler()
    let assembler: Assembler
    
    public override init() {
        let base = Assembler(container: AppContainer.instance.container)
        assembler = RootAssembler.registerModules(using: base)
        super.init()
    }
    
    //Register here your new module
    class func registerModules(using base: Assembler) -> Assembler {
        return base.withModules { context in
            context.register(AppModule.self)
            context.register(FeedModule.self)
        }
    }
}
