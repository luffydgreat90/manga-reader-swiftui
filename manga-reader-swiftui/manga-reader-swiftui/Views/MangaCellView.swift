//
//  MangaCellView.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 17/05/2025.
//

import SwiftUI

struct MangaCellView: View {
    let mangaViewData: MangaViewData

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(mangaViewData.title)
                    .font(.title2.bold())
                    .foregroundStyle(.white)

                Text(mangaViewData.description)
                    .font(.caption)
                    .foregroundStyle(.white)
            }

        }
        .padding()
        .frame(minWidth: 0,maxWidth: .infinity)
        .background(.black.gradient)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    MangaCellView(mangaViewData: MangaViewData.makeMock())
}
