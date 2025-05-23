//
//  MangaListView.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 17/05/2025.
//

import SwiftUI

struct MangaListView: View {
    @State private var searchText = ""
    var items: [MangaViewData]

    var body: some View {
        NavigationView {
                    List(items, id: \.self) { item in
                        MangaCellView(mangaViewData: item)
                            .listRowSeparator(.hidden)
                    }
                    .navigationTitle("Fruits")
                    .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
                    .scrollContentBackground(.hidden)
                }
    }
}

#Preview {
    MangaListView(items: [MangaViewData.makeMock(), MangaViewData.makeMock(id: "test1")])
}
