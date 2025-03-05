//
//  MovieDetailView.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//
import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 100)
            } else {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    MovieHeaderView(
                        posterPath: viewModel.movie?.posterPath,
                        tagline: viewModel.movie?.tagline,
                        overview: viewModel.movie?.overview
                    )
                    
                    // Metadata
                    MovieMetadataView(
                        status: viewModel.movie?.status,
                        runtime: viewModel.movie?.runtime,
                        budget: viewModel.movie?.budget,
                        revenue: viewModel.movie?.revenue
                    )
                    
                    // Cast
                    if let cast = viewModel.movie?.credits?.cast, !cast.isEmpty {
                        SectionView(title: "Cast") {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(cast.prefix(10)) { member in
                                        CastMemberView(member: member)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // Similar Movies
                    if let similar = viewModel.movie?.similar?.results, !similar.isEmpty {
                        SectionView(title: "More Like This") {
                            MovieHorizontalScroll(movies: similar)
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.movie?.title ?? "Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(
                    item: URL(string: "https://www.themoviedb.org/movie/\(movieId)")!,
                    message: Text("Check out \(viewModel.movie?.title ?? "this movie")!")
                )
            }
        }
        .task {
            await viewModel.fetchMovieDetails(for: movieId)
        }
    }
}
