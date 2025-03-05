//
//  CategoryRow.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 4/3/25.
//


import SwiftUI

struct CategoryRow: View {
    let genres: [Genre]
    @Binding var selectedGenreId: Int?
    let onSelect: (Int) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(genres) { genre in
                    Text(genre.name)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selectedGenreId == genre.id ? Color(hex: Constants.selectedGenreBackgroundColor) : .clear)
                        .foregroundColor(selectedGenreId == genre.id ? .white : .gray)
                        .cornerRadius(20)
                        .onTapGesture {
                            onSelect(genre.id)
                        }
                }
            }
            .padding(8)
        }
    }
}
