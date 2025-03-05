//
//  Movie.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 4/3/25.
//


struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String
    let popularity: Double
    let runtime: Int?
    let tagline: String?
    let budget: Int?
    let revenue: Int?
    let status: String?
    let credits: Credits?
    let similar: MovieResponse?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case popularity
        case runtime, tagline, budget, revenue, status
        case credits
        case similar = "recommendations"
    }
}
