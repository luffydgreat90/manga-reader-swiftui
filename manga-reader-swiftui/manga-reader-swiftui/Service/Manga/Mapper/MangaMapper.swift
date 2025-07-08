//
//  Untitled.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 04/05/2025.
//

import Foundation

enum MangaMapper {
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
        let attributes: [String: DecodableValue]?
    }

    private struct Tag: Decodable {
        let id: String
        let attributes: TagAttributes
    }

    private struct TagAttributes: Decodable {
        let name: Language
    }

    private struct CoverAttribute: Decodable {
        let fileName: String
    }

    static func map(data: Data, httpResponse: HTTPURLResponse) throws -> [MangaViewData] {
        let jsonDecoder = JSONDecoder()

        guard let result = try? jsonDecoder.decode(Result.self, from: data) else {
            throw MapError.invalid
        }

        return result.data.map { manga in
            let coverAttributes = manga.relationships.filter({ $0.type == "cover_art" }).first?.attributes
            let tags = manga.attributes.tags.map { TagsViewData(title: $0.attributes.name.en ?? "" )}
            var coverUrl: URL?

            if let fileNameValue = coverAttributes?["fileName"], case let .string(fileName) = fileNameValue {
                coverUrl = URL(string: "https://uploads.mangadex.org/covers/\(manga.id)/\(fileName).256.jpg")
            }

            return MangaViewData(id: manga.id,
                                 title: manga.attributes.title.en ?? "",
                                 description: manga.attributes.description.en ?? "",
                                 tags: tags,
                                 contentRating: manga.attributes.contentRating,
                                 coverUrl: coverUrl)
        }
    }

}

enum DecodableValue: Decodable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case array([DecodableValue])
    case dictionary([String: DecodableValue])
    case null

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([String: DecodableValue].self) {
            self = .dictionary(value)
        } else if let value = try? container.decode([DecodableValue].self) {
            self = .array(value)
        } else {
            throw DecodingError.typeMismatch(
                DecodableValue.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unknown type")
            )
        }
    }
}
