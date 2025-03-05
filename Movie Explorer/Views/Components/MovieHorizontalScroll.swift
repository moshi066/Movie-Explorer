//
//  MovieHorizontalScroll.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 4/3/25.
//


import SwiftUI

struct MovieHorizontalScroll: View {
    let movies: [Movie]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(movies) { movie in
                    MoviePosterCell(movie: movie)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 200)  // Fixed height prevents vertical expansion
    }
}
