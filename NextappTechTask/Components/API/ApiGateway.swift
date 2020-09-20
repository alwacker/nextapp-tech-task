//
//  ApiGateway.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation

public protocol Gateway {
    func getEndpointURL(endPoint: ApiEndPoint) -> String
    func getEndpointURL(endPoint: String) -> String
}

public class ApiGateway: Gateway {
    private let baseUrl: String
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public func getEndpointURL(endPoint: String) -> String {
        return prepareUrl(endPoint: endPoint)
    }
    
    public func getEndpointURL(endPoint: ApiEndPoint) -> String {
        let url = endPoint.rawValue.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? endPoint.rawValue
        return prepareUrl(endPoint: url)
    }
    
    private func prepareUrl(endPoint: String) -> String {
        let url = endPoint.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? endPoint
        return "\(baseUrl)\(url)"
    }
}
