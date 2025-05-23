//
//  MangaObservable.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 23/05/2025.
//

import Observation

@Observable
final class MangaObservable {
    var mangViewDatas: [MangaViewData] = []

    init(mangViewDatas: [MangaViewData] = []) {
        self.mangViewDatas = mangViewDatas
    }
}
