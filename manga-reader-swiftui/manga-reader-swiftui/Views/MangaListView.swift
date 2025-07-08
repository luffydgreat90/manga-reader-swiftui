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
    @EnvironmentObject var mangaService: MangaService
    @State var query: String = ""
    @State private var task: Task<Void, Never>?
    private let debounceDelay: UInt64 = 300_000_000 // 300ms debounce

    private let openURL: (URL?) -> Void

    init(openURL: @escaping (URL?) -> Void) {
        self.openURL = openURL
    }

    var body: some View {
        NavigationStack {
            List(mangaService.mangaViewDatas, id: \.self) { item in
                NavigationLink(destination: MangaDetailView(mangaViewData: item)) {
                    MangaCellView(mangaViewData: item, onTapDescription: {

                    })
                }
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
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
            try? await Task.sleep(nanoseconds: debounceDelay)
            do {
                try await mangaService.searchManga(search: query)
            } catch {
                
            }
        }
    }
}

#Preview {
    let mangaService =  MangaService(
        urlSession: URLSessionHTTPClient(session: .shared),
        baseURL: URL(string: "test")!,
        mangaViewDatas: [MangaViewData.makeMock(id: "test1"),
                         MangaViewData.makeMock(id: "test2", title: "one piece")]
    )

    MangaListView(openURL: { _ in })
        .environmentObject(mangaService)
}
