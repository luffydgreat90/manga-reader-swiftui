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
    let coverId: String?
    let tags: [TagsViewData]
    let contentRating: String?
}

struct TagsViewData: Hashable {
    let title: String
}

extension MangaViewData {
    static func makeMock(id: String = "test", title: String = "test") -> MangaViewData {
        MangaViewData(
            id: id,
            title: title,
            description: "here is a test description",
            coverId: nil,
            tags: [],
            contentRating: "test"
        )
    }
}
