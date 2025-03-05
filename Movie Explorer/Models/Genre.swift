//
//  Genre.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 4/3/25.
//


struct Genre: Codable, Identifiable {
    let id: Int
    let name: String
}



extension Genre {
    static let example = Genre(id: 28, name: "Action")
}
