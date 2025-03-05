//
//  MovieListView.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 4/3/25.
//

import SwiftUI

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color(hex: Constants.navBackgroundedColor))
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 19, weight: .bold)
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    CategoryRow(
                        genres: viewModel.genres,
                        selectedGenreId: $viewModel.selectedGenreId,
                        onSelect: { genreId in
                            Task {
                                await viewModel.selectGenre(genreId)
                            }
                        }
                    )
                    .padding(.top)
                    
                    MovieHorizontalScroll(movies: viewModel.selectedCategoryMovies)
                    
                    Text("Most Popular")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    MovieHorizontalScroll(movies: viewModel.popularMovies)
                    
                    Spacer()
                }
            }
            .background(Color(hex: Constants.appBackgroundedColor))
            .navigationTitle("Movie")
            .refreshable {
                await viewModel.handleRefresh()
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
            }
            .alert("Error",
                   isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onAppear {
                Task {
                    await viewModel.fetchInitialData()
                }
            }
            .navigationDestination(for: Int.self) { movieId in
                MovieDetailView(movieId: movieId)
            }
        }
    }
}
