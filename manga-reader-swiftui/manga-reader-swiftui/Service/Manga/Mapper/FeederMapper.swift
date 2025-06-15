//
//  FeederMapper.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 15/06/2025.
//

import Foundation

enum FeederMapper {
    private struct Result: Decodable {
        let data: [Feeder]
    }

    private struct Feeder: Decodable {
        let id: String
        let attributes: Attributes
    }

    private struct Attributes: Decodable {
        let title: String
        let volume: String
        let updatedAt: String
        let chapter: String
        let pages: Int
    }

    static func map(data: Data, httpResponse: HTTPURLResponse) throws -> [FeederViewData] {
        let jsonDecoder = JSONDecoder()

        guard let result = try? jsonDecoder.decode(Result.self, from: data) else {
            throw MapError.invalid
        }

        return result.data.map {
            FeederViewData(
                id: $0.id,
                title: $0.attributes.title,
                updatedAt: $0.attributes.updatedAt,
                chapter: $0.attributes.chapter,
                volume: $0.attributes.volume
            )
        }.sorted {
            $0.chapter.toDouble()  < $1.chapter.toDouble()
        }
    }
}
