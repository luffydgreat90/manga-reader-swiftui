//
//  MangaService.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 04/05/2025.
//

import SwiftUI

final class MangaService: ObservableObject {
    enum APIError: Error {
        case invalidURL
    }

    private let urlSession: URLSessionProtocol
    private let baseURL: URL
    @Published private(set) var mangaViewDatas: [MangaViewData] = []
    @Published private(set) var feederViewDatas: [FeederViewData] = []

    init(urlSession: URLSessionProtocol,
         baseURL: URL,
         mangaViewDatas: [MangaViewData] = [],
         feederViewDatas: [FeederViewData] = []) {
        self.urlSession = urlSession
        self.baseURL = baseURL
        self.mangaViewDatas = mangaViewDatas
        self.feederViewDatas = feederViewDatas
    }

    func searchManga(search: String) async throws {
        let result = try await urlSession.get(from: MangaEndPoint.get(search: search).url(baseURL: baseURL))

        let mapped = try MangaMapper.map(data: result.0, httpResponse: result.1)
        await MainActor.run { self.mangaViewDatas = mapped }
    }

    func getFeeder(id: String) async throws {
        let result = try await urlSession.get(from: MangaEndPoint.getFeeder(id: id).url(baseURL: baseURL))

        let mapped = try FeederMapper.map(data: result.0, httpResponse: result.1)
        await MainActor.run { self.feederViewDatas = mapped }
    }

    func getFeederImages(chapterId: String) async throws -> [URL] {
        let result = try await urlSession.get(from: MangaEndPoint.getFeederImages(chapterId: chapterId).url(baseURL: baseURL))

        return try FeederImagesMapper.map(data: result.0, httpResponse: result.1)
    }

    func clearFeeder() async {
        await MainActor.run { self.feederViewDatas = [] }
    }
}
