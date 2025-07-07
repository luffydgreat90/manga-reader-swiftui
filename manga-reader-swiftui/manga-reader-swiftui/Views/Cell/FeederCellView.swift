//
//  FeederCellView.swift
//  manga-reader-swiftui
//
//  Created by marlon von ansale on 15/06/2025.
//

import SwiftUI

struct FeederCellView: View {
    let feederViewData: FeederViewData

    var body: some View {
        VStack(
            alignment: .trailing,
            spacing: 8
        ) {
            Text(feederViewData.title)
                .font(.title3.bold())
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading)

            Text(feederViewData.chapterVolume)
                .font(.caption)
                .lineLimit(3)
                .truncationMode(.tail)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                ).onTapGesture {
                  //  onTapDescription()
                }
        }
        .padding()
        .frame(
            minWidth: 0,
            maxWidth: .infinity
        )
        .background(
            .black.gradient
        )
        .clipShape(
            .rect(
                cornerRadius: 10
            )
        )
        .foregroundStyle(
            .white
        )

    }
}

#Preview {
    FeederCellView(
        feederViewData: FeederViewData.makeMock()
    )
}
