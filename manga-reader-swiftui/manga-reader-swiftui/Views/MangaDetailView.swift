//
//  MangaDetailView.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 15/06/2025.
//

import SwiftUI

struct MangaDetailView: View {
    @EnvironmentObject private var mangaService: MangaService
    let mangaViewData: MangaViewData
    
    var body: some View {
        NavigationStack {
            List(mangaService.feederViewDatas, id: \.self) { item in
                NavigationLink(destination: ChapterView(feederViewData: item)) {
                    FeederCellView(feederViewData: item)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle(mangaViewData.title)
        }.task {
            try? await mangaService.getFeeder(id: mangaViewData.id)
        }.onDisappear {
            Task {
                await  mangaService.clearFeeder()
            }
        }
    }
}


#Preview {
    let mangaService =  MangaService(
        urlSession: URLSessionHTTPClient(session: .shared),
        baseURL: URL(string: "test")!,
        feederViewDatas: [FeederViewData.makeMock(),FeederViewData.makeMock(id: "2", title: "title 2")]
    )

    NavigationStack {
        MangaDetailView(mangaViewData: MangaViewData.makeMock(id: "test1"))
            .environmentObject(mangaService)
    }
}

