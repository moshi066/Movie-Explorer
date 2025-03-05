//
//  CrewMember.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//


struct CrewMember: Codable, Identifiable {
    let id: Int
    let name: String
    let job: String
    let department: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case job
        case department
    }
}
