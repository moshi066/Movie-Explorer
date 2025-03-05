//
//  MoviePosterCell.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 4/3/25.
//


import SwiftUI

struct MoviePosterCell: View {
    let movie: Movie
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        NavigationLink(value: movie.id) {
            VStack(alignment: .leading, spacing: 8) {
                // Poster Image
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Color.gray.opacity(0.3)
                }
            }
            .frame(width: 120)
            .cornerRadius(8)
            .clipped()
            .onAppear {
                if let posterPath = movie.posterPath {
                    imageLoader.load(fromURLString: posterPath)
                }
            }
        }
    }
}
