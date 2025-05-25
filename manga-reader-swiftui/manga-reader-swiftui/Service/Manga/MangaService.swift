//
//  MangaService.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 04/05/2025.
//

import SwiftUI
import Observation

@Observable
final class MangaService {
    enum APIError: Error {
        case invalidURL
    }

    private let urlSession: URLSessionProtocol
    private let baseURL: URL
    private(set) var mangaViewDatas: [MangaViewData] = []

    init(urlSession: URLSessionProtocol,
         baseURL: URL,
         mangaViewDatas: [MangaViewData] = []) {
        self.urlSession = urlSession
        self.baseURL = baseURL
        self.mangaViewDatas = mangaViewDatas
    }

    func searchManga(search: String) async throws {
        let result = try await urlSession.get(from: MangaEndPoint.get(search: search).url(baseURL: baseURL))

        mangaViewDatas = try MangaMapper.map(data: result.0, httpResponse: result.1)
    }
}
