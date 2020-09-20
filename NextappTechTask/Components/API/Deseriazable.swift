//
//  Deseriazable.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 19/09/2020.
//

import Foundation

extension Decodable {
    public static func decode(data: Data) throws -> Self {
        let cleanedData: Data
        if data.count == 0 {
            guard let emptyJsonData = "{}".data(using: .utf8) else {
                throw NSError(
                    domain: "Alza.cz",
                    code: 0,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Failed to create data from empty json string"
                    ]
                )
            }
            cleanedData = emptyJsonData
        } else {
            cleanedData = data
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Self.self, from: cleanedData)
    }
}
