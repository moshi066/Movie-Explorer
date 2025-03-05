//
//  MovieViewModel.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 4/3/25.
//


import Foundation

@MainActor
final class MovieViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var genres: [Genre] = []
    @Published var selectedCategoryMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService: APIService
    public var selectedGenreId: Int?
    
    nonisolated init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func fetchInitialData() async {
        await fetchGenres()
        await fetchPopularMovies()
    }
    
    func selectGenre(_ genreId: Int) async {
        selectedGenreId = genreId
        await fetchMoviesForSelectedGenre()
    }
    
    func handleRefresh() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { await self.fetchMoviesForSelectedGenre() }
            group.addTask { await self.fetchPopularMovies() }
        }
    }
    
    func fetchGenres() async {
        isLoading = true
        do {
            let response: GenreResponse = try await apiService.fetch(APIEndpoint.genres.path)
            genres = response.genres
            if let firstGenre = response.genres.first {
                await selectGenre(firstGenre.id)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func fetchMovieDetails(for movieId: Int) async {
        isLoading = true
        do {
            let response: Movie = try await apiService.fetch(APIEndpoint.movieDetails(movieId).path)
            movie = response
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func fetchMoviesForSelectedGenre() async {
        guard let genreId = selectedGenreId else { return }
        do {
            let response: MovieResponse = try await apiService.fetch(APIEndpoint.moviesByGenre(genreId).path)
            selectedCategoryMovies = response.results
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchPopularMovies() async {
        do {
            let response: MovieResponse = try await apiService.fetch(APIEndpoint.popularMovies.path)
            popularMovies = response.results
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
