//
//  MovieResponse.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 4/3/25.
//


struct MovieResponse: Codable {
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
