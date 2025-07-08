//
//  MangaEndPoint.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 17/05/2025.
//
import Foundation

enum MangaEndPoint {
    case get(search: String)
    case getFeeder(id: String)
    case getFeederImages(chapterId: String)

    func url(baseURL: URL) -> URL? {
        switch self {
        case let .get(search):
            return URL(string: "\(baseURL.absoluteString)/manga?title=\(search)&includes[]=cover_art")
        case .getFeeder(let id):
            return URL(string: "\(baseURL.absoluteString)/manga/\(id)/feed?translatedLanguage[]=en")
        case .getFeederImages(let chapterId):
            return URL(string: "\(baseURL.absoluteString)/at-home/server/\(chapterId)")
        }
    }
}
