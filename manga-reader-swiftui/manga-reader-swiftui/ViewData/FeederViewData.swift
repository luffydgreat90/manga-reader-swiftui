//
//  FeederViewData.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 15/06/2025.
//

struct FeederViewData: Hashable {
    let id: String
    let title: String
    let updatedAt: String
    let chapter: String
    let volume: String
}

extension FeederViewData {

    static func makeMock(id: String = "1", title: String = "test title") -> FeederViewData {
        FeederViewData(
            id: id,
            title: title,
            updatedAt: "",
            chapter: "1",
            volume: "2"
        )
    }

    var chapterVolume: String {
        "Chapter \(chapter) - Volume \(volume)"
    }
}
