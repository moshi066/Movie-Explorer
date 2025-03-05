//
//  InfoCell.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//

import SwiftUI

struct InfoCell: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
            Text(value)
                .font(.title3.bold())
                .foregroundColor(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 2)
        )
    }
}
