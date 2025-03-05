//
//  MockAPIService.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//

import Foundation
@testable import Movie_Explorer

class MockAPIService: APIService {
    var mockData: Data?
    var mockError: Error?
    
    override init() {
        super.init()
    }
    
    override func fetch<T: Decodable>(_ endpoint: String) async throws -> T {
        if let error = mockError {
            throw error
        }
        
        guard let data = mockData else {
            throw APIError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw APIError.decodingFailed(error)
        }
    }
}
