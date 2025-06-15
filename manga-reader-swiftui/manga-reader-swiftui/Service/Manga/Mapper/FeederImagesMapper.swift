//
//  FeederImagesMapper.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 15/06/2025.
//

import Foundation

enum FeederImagesMapper {

    private struct Result: Decodable {
        let baseUrl: String
        let chapter: Chapter
    }

    private struct Chapter: Decodable {
        let hash: String
        let data: [String]
    }

    static func map(data: Data, httpResponse: HTTPURLResponse) throws -> [URL] {
        let jsonDecoder = JSONDecoder()

        guard let result = try? jsonDecoder.decode(Result.self, from: data) else {
            throw MapError.invalid
        }

        let baseURL = result.baseUrl
        let hash = result.chapter.hash

        return result.chapter.data.compactMap {
            URL(string: "\(baseURL)/data/\(hash)/\($0)")
        }
    }
}
