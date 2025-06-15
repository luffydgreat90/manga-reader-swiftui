//
//  MangaCellView.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 17/05/2025.
//

import SwiftUI

struct MangaCellView: View {
    let mangaViewData: MangaViewData
    let onTapDescription: () -> Void

    init(mangaViewData: MangaViewData,
         onTapDescription: @escaping () -> Void) {
        self.mangaViewData = mangaViewData
        self.onTapDescription = onTapDescription
    }

    var body: some View {
        VStack(
            alignment: .trailing,
            spacing: 8
        ) {
            HStack {
                Text(mangaViewData.title)
                    .font(.title3.bold())
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )

                Spacer()
                Button(
                    action: {

                    }) {
                        Image(systemName: "star")
                            .resizable()
                            .frame(
                                width: 15,
                                height: 15
                            )
                            .clipShape(Circle())
                    }
            }

            Text(mangaViewData.description)
                .font(.caption)
                .lineLimit(3)
                .truncationMode(.tail)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                ).onTapGesture {
                    onTapDescription()
                }
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
        )

    }
}

#Preview {
    MangaCellView(
        mangaViewData: MangaViewData.makeMock(title: "Hellsing: The Legend of a Vampire Hunter"), onTapDescription: {

    })
}
