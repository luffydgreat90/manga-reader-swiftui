//
//  MangaCellView.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 17/05/2025.
//

import SwiftUI

struct MangaCellView: View {
    let mangaViewData: MangaViewData
    let onTapCell: () -> Void

    init(mangaViewData: MangaViewData,
         onTapCell: @escaping () -> Void) {
        self.mangaViewData = mangaViewData
        self.onTapCell = onTapCell
    }

    var body: some View {
        VStack(
            alignment: .trailing,
            spacing: 8
        ) {
            HStack {
                AsyncImage(url: mangaViewData.coverUrl)
                    .frame(maxWidth: 150, maxHeight: 150)
                    .scaledToFill()
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text(mangaViewData.title)
                    .font(.subheadline.bold())
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .lineLimit(3)
            }

            Text(mangaViewData.description)
                .font(.caption)
                .lineLimit(3)
                .truncationMode(.tail)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
        }
        .padding()
        .frame(
            minWidth: 0,
            maxWidth: .infinity
        )
        .background(
            .black.gradient
        )
        .clipShape(
            .rect(
                cornerRadius: 10
            )
        )
        .foregroundStyle(
            .white
        ).onTapGesture {
            onTapCell()
        }

    }
}

#Preview {
    MangaCellView(
        mangaViewData: MangaViewData.makeMock(title: "Hellsing: The Legend of a Vampire Hunter"), onTapCell: {

    })
}
