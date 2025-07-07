//
//  ChapterView.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 15/06/2025.
//

import SwiftUI

struct ChapterView: View {
    @EnvironmentObject var mangaService: MangaService
    let feederViewData: FeederViewData
    @State var images: [URL] = []
    @State var selected: Int = 0

    var body: some View {
        VStack {
            Text(feederViewData.title)
            if !images.isEmpty {
                AsyncImage(url: images[selected]) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ProgressView()
            }
        }.task {
            do {
                images = try await mangaService.getFeederImages(chapterId: feederViewData.id)
            } catch {
                // no-op
            }
        }
    }
}

#Preview {
    ChapterView(feederViewData: FeederViewData(id: "1", title: "test", updatedAt: "", chapter: "1", volume: "1"))
}
