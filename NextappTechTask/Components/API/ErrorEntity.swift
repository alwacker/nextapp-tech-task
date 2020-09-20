//
//  ErrorEntity.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation

public struct ErrorEntity : Decodable, CustomNSError {
    public static var errorDomain = "Alza.cz"
    public var errorUserInfo: [String : Any] {
        return message.map { [NSLocalizedDescriptionKey: $0] } ?? [:]
    }
    enum CodingKeysNew : String, CodingKey {
        case message
    }
    
    public let errorCode: Int
    public let message: String?
    
    public init(errorCode: Int, message: String?) {
        self.errorCode = errorCode
        self.message = message
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: ErrorEntity.CodingKeys.self)
            let code = try container.decode(Int.self, forKey: .errorCode)
            let message = try container.decodeIfPresent(String.self, forKey: .message)
            self.errorCode = code
            self.message = message
        } catch {
            let container = try decoder.container(keyedBy: ErrorEntity.CodingKeysNew.self)
            let message = try container.decodeIfPresent(String.self, forKey: .message)
            self.errorCode = 0
            self.message = message
        }
    }
    enum CodingKeys : String, CodingKey {
        case errorCode = "err"
        case message = "msg"
    }
}
