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
        VStack {
            HStack {
                Text(mangaViewData.description)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .navigationTitle(mangaViewData.title)
    }
}

#Preview {
    let mangaService =  MangaService(
        urlSession: URLSessionHTTPClient(session: .shared),
        baseURL: URL(string: "test")!)

    NavigationStack {
        MangaDetailView(mangaViewData: MangaViewData.makeMock(id: "test1"))
            .environmentObject(mangaService)
    }
}
