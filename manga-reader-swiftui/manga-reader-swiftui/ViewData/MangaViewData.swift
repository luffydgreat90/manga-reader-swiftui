//
//  MangaViewData.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 04/05/2025.
//

import Foundation

struct MangaViewData: Hashable {
    let id: String
    let title: String
    let description: String
    let tags: [TagsViewData]
    let contentRating: String?
    let coverUrl: URL?
}

struct TagsViewData: Hashable {
    let title: String
}

extension MangaViewData {
    static func makeMock(id: String = "test", title: String = "test", description: String = "here is a test description") -> MangaViewData {
        MangaViewData(
            id: id,
            title: title,
            description: description,
            tags: [],
            contentRating: "test",
            coverUrl: URL(string: "https://uploads.mangadex.org/covers/8f3e1818-a015-491d-bd81-3addc4d7d56a/26dd2770-d383-42e9-a42b-32765a4d99c8.png?150.jpg")
        )
    }
}
