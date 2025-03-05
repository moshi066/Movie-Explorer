//
//  CastMember.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//


struct CastMember: Codable, Identifiable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case character
    }
}
