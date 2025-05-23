//
//  MangaEndPoint.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 17/05/2025.
//
import Foundation

enum MangaEndPoint {
    case get(search: String)

    func url(baseURL: URL) -> URL? {

        switch self {
        case let .get(search):
            return URL(string: "\(baseURL.absoluteString)/manga?title=\(search)")
        }
    }
}
