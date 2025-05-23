//
//  Untitled.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 04/05/2025.
//

import Foundation

enum MangaMapper {
    enum MapError: Error {
        case invalid
    }

    private struct Result: Decodable {
        let data: [Manga]
    }

    private struct Manga: Decodable {
        let id: String
        let type: String
        let attributes: Attributes
        let relationships: [Relationship]
    }

    private struct Attributes: Decodable {
        let title: Language
        let description: Language
        let latestUploadedChapter: String
        let tags: [Tag]
        let contentRating: String?
    }

    private struct Language: Decodable {
        let en: String?
    }

    private struct Relationship: Decodable {
        let id: String
        let type: String
    }

    private struct Tag: Decodable {
        let id: String
        let attributes: TagAttributes
    }

    private struct TagAttributes: Decodable {
        let name: Language
    }

    static func map(data: Data, httpResponse: HTTPURLResponse) throws -> [MangaViewData] {
        let jsonDecoder = JSONDecoder()

        guard let result = try? jsonDecoder.decode(Result.self, from: data) else {
            throw MapError.invalid
        }

        return result.data.map { manga in
            let coverId = manga.relationships.filter({ $0.type == "cover_art" }).first?.id
            let tags = manga.attributes.tags.map { TagsViewData(title: $0.attributes.name.en ?? "" )}

            return MangaViewData(title: manga.attributes.title.en ?? "",
                                 description: manga.attributes.description.en ?? "",
                                 coverId: coverId,
                                 tags: tags,
                                 contentRating: manga.attributes.contentRating)
        }
    }

}
