//
//  MangaService.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 04/05/2025.
//

import Foundation

final class MangaService {
    enum APIError: Error {
        case invalidURL
    }

    private let urlSession: URLSessionProtocol
    private let baseURL: URL

    init(urlSession: URLSessionProtocol,
         baseURL: URL) {
        self.urlSession = urlSession
        self.baseURL = baseURL
    }

    func searchManga(search: String) async throws -> [MangaViewData] {
        let result = try await urlSession.get(from: MangaEndPoint.get(search: search).url(baseURL: baseURL))

        return try MangaMapper.map(data: result.0, httpResponse: result.1)
    }
}
