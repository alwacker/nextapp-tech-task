//
//  BaseApi.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation
import Alamofire
import RxSwift
import RxSwiftExt

public enum ApiEvent<T> {
    case loading
    case loaded(T)
    case error(Error)
    
    public var isLoaded: Bool {
        if case .loaded = self {
            return true
        }
        return false
    }
    
    public var isLoading: Bool {
        if case .loading = self {
            return true
        } else {
            return false
        }
    }
    
    public var isError: Bool {
        if case .error = self {
            return true
        } else {
            return false
        }
    }
    
    var loaded: T? {
        guard case .loaded(let value) = self else { return nil }
        return value
    }
    
    var error: Error? {
        guard case .error(let value) = self else { return nil }
        return value
    }
}

extension ApiEvent: Equatable where T: Equatable {
    public static func == (lhs: ApiEvent<T>, rhs: ApiEvent<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.error, .error):
            return true
        case (.loaded(let l), .loaded(let r)):
            return l == r
        default:
            return false
        }
    }
}

public class BaseApi {
    private let base: ApiGateway
    
    public init(base: ApiGateway) {
        self.base = base
    }
    
    public init(baseUrl: String) {
        self.base = ApiGateway(baseUrl: baseUrl)
    }
    
    func getEndpointUrl(endPoint: ApiEndPoint) -> String {
        return base.getEndpointURL(endPoint: endPoint)
    }
    
    func getEndpointUrl(endPoint: String) -> String {
        return base.getEndpointURL(endPoint: endPoint)
    }
    
    public func request<T:Decodable>(endPoint: ApiEndPoint, method: Method = .get, params: [String: Any]? = nil, headers: HTTPHeaders? = nil) -> Observable<ApiEvent<T>> {
        return ApiProvider.instance.request(endPoint: getEndpointUrl(endPoint: endPoint), method: method, params: params, headers: headers)
    }
    
    public func request<T:Decodable>(endPoint: String, method: Method = .get, params: [String: Any]? = nil, headers: HTTPHeaders? = nil) -> Observable<ApiEvent<T>> {
        return ApiProvider.instance.request(endPoint: getEndpointUrl(endPoint: endPoint), method: method, params: params, headers: headers)
    }
}
