//
//  Untitled.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 28/04/2025.
//

import Foundation

protocol URLSessionProtocol {
    func get(from url: URL?) async throws -> URLResult
}

typealias URLResult = (Data, HTTPURLResponse)

final class URLSessionHTTPClient: URLSessionProtocol {
    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    private enum LoadError: Error {
        case invalidURL
        case failed
    }

    func get(from url: URL?) async throws -> URLResult {
        guard let url else {
            throw LoadError.invalidURL
        }

        let result = try await session.data(from: url)

        guard let response = result.1 as? HTTPURLResponse else {
            throw LoadError.failed
        }

        return( result.0, response)
    }
}
