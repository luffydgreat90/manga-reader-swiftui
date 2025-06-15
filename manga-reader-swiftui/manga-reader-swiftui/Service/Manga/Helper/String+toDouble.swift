//
//  String+toDouble.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 15/06/2025.
//

import Foundation

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0
    }
}
