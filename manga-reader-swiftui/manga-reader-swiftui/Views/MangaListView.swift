//
//  MangaListView.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 17/05/2025.
//

import SwiftUI
import Observation

@MainActor
struct MangaListView: View {
    @Bindable var mangaService: MangaService
    @State var query: String = ""
    @State private var task: Task<Void, Never>?

    private let openURL: (URL?) -> Void

    init(mangaService: MangaService,
         openURL: @escaping (URL?) -> Void) {
        self.mangaService = mangaService
        self.openURL = openURL
    }

    var body: some View {
        NavigationView {
            List(mangaService.mangaViewDatas, id: \.self) { item in
                MangaCellView(mangaViewData: item) {
                    let url = URL(string: "https://mangadex.org/title/" + item.id)
                    openURL(url)
                }.listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity) .listRowBackground(Color.clear)
                }
                .navigationTitle("MangaDex")
                .listStyle(PlainListStyle())
                .searchable(text: $query)
                .onChange(of: query, { _, newValue in
                    searchManga(query: newValue)
                })
                .scrollContentBackground(.hidden)
                .animation(.easeInOut, value: mangaService.mangaViewDatas)
        }.task {
            searchManga(query: "")
        }
    }

    private func searchManga(query: String) {
        task?.cancel()
        task = Task {
            try? await Task.sleep(nanoseconds: 300_000_000)
            do {
                try await mangaService.searchManga(search: query)
            } catch {

            }
        }
    }
}

#Preview {
    MangaListView(
        mangaService: MangaService(
            urlSession: URLSessionHTTPClient(session: .shared),
            baseURL: URL(string: "test")!,
            mangaViewDatas: [MangaViewData.makeMock(id: "test1"),
                             MangaViewData.makeMock(id: "test2", title: "one piece")]
        ), openURL: { _ in

        }
    )
}
