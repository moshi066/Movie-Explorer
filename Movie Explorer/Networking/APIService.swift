//
//  APIService.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 4/3/25.
//


import Foundation

class APIService {
    static let shared = APIService()
    private let urlSession: URLSession
    private let decoder = JSONDecoder()
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        self.urlSession = URLSession(configuration: configuration)
    }
    
    func fetch<T: Decodable>(_ endpoint: String) async throws -> T {
        let urlString = "\(Constants.baseURL)\(endpoint)&api_key=\(Constants.tmdbAPIKey)"
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        request.timeoutInterval = 30
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed(error)
        }
    }
}


