//
//  MangaListView.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 17/05/2025.
//

import SwiftUI
import Observation

struct MangaListView: View {
    var mangaService: MangaService
    @State var query: String = ""

    var body: some View {
        NavigationView {
            List(mangaService.mangaViewDatas, id: \.self) { item in
                        MangaCellView(mangaViewData: item)
                            .listRowSeparator   (.hidden)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                UIApplication.shared.open(URL(string: "https://mangadex.org/title/" + item.id)!)
                            }

                    }
                    .navigationTitle("MangaDex")
                    .listStyle(PlainListStyle())
                    .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .automatic))
                    .scrollContentBackground(.hidden)


        }.task {
            do {
                try await mangaService.searchManga()
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
                             MangaViewData.makeMock(id: "test2")]
        )
    )
}
