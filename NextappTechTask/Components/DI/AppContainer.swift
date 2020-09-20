//
//  AppContainer.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import Swinject
import SwinjectAutoregistration

public class AppContainer: NSObject {
    public static let instance = AppContainer()
    internal let container = Container()
    
    override init() {
        container.register(Resolver.self) { resolver in
            return resolver
        }
        
        container.register(Gateway.self) { resolver in
            return resolver.resolve(Gateway.self)!
        }
        
        container.register(ApiGateway.self) { resolver in
            return ApiGateway(baseUrl: "https://api.steller.co")
        }
        super.init()
    }
}
