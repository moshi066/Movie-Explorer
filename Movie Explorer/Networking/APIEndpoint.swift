//
//  APIEndpoint.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//


import Foundation

enum APIEndpoint {
    case genres
    case moviesByGenre(Int)
    case popularMovies
    case movieDetails(Int)
    
    var path: String {
        switch self {
        case .genres:
            return "/genre/movie/list?"
        case .moviesByGenre(let genreId):
            return "/discover/movie?with_genres=\(genreId)"
        case .popularMovies:
            return "/movie/popular?"
        case .movieDetails(let id):
            return "/movie/\(id)?append_to_response=credits,recommendations&"
        }
    }
}
