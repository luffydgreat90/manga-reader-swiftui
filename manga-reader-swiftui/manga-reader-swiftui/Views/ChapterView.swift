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
        ZStack {
            if images.count > 0 {
                AsyncImage(url: images[selected])
            } else {
                Text("Loading...")
            }
        }.task {
            do {
                images = try await mangaService.getFeederImages(chapterId: feederViewData.id)
            }catch {
                // no-op
            }
        }
    }
}

#Preview {
    ChapterView(feederViewData: FeederViewData(id: "1", title: "test", updatedAt: "", chapter: "1", volume: "1"))
}
