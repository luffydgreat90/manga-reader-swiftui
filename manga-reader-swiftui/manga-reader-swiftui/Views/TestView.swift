//
//  TestView.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 25/05/2025.
//

import SwiftUI
import Observation

@Observable
class SearchModel {
    var query = ""
    var allItems = ["Apple", "Banana", "Cherry", "Date", "Fig", "Grape", "Kiwi"]

    var filteredItems: [String] {
        if query.isEmpty {
            return allItems
        } else {
            return allItems.filter { $0.localizedCaseInsensitiveContains(query) }
        }
    }
}

struct SearchView: View {
    var model = SearchModel()
    @State var query = ""
    var body: some View {
        NavigationView {
            List(model.filteredItems, id: \.self) { item in
                Text(item)
            }
            .searchable(text: $query)
            .navigationTitle("Fruit Search")
        }
    }
}

#Preview {
    SearchView()
}
