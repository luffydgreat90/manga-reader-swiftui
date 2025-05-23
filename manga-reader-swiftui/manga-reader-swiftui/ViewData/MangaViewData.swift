//
//  MangaViewData.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 04/05/2025.
//

import Foundation

struct MangaViewData {
    let title: String
    let description: String
    let coverId: String?
    let tags: [TagsViewData]
    let contentRating: String?
}

struct TagsViewData {
    let title: String
}

extension MangaViewData {
    static func makeMock() -> MangaViewData {
        MangaViewData(
            title: "test",
            description: "here is a test description",
            coverId: nil,
            tags: [],
            contentRating: "test"
        )
    }
}
