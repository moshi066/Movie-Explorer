//
//  APIError.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//


import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decodingFailed(Error)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL format"
        case .invalidResponse:
            return "Received invalid response from server"
        case .statusCode(let code):
            return "Server returned status code \(code)"
        case .decodingFailed(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}