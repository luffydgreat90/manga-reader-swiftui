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
            Text(mangaViewData.title).font(.title.bold())
                .lineLimit(3)

            HStack {
                AsyncImage(url: mangaViewData.coverUrl)
                    .frame(maxWidth: 150, maxHeight: 180)
                    .scaledToFill()
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text(mangaViewData.description)
                    .lineLimit(6)
            }
            
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        ).padding()
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
