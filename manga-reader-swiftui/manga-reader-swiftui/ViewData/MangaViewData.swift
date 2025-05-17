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
    let cover: URL?
    let tags: [TagsViewData]
    let contentRating: String?
}

struct TagsViewData {
    let title: String
}
