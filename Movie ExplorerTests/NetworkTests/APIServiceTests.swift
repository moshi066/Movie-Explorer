//
//  APIServiceTests.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//

import XCTest
@testable import Movie_Explorer

// APIServiceTests.swift
import XCTest
@testable import Movie_Explorer

class APIServiceTests: XCTestCase {

    var apiService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        apiService = MockAPIService()
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }

    func testFetchGenresSuccess() async {
        let mockResponse = """
        {
            "genres": [{"id": 1, "name": "Action"}]
        }
        """.data(using: .utf8)
        
        apiService.mockData = mockResponse
        
        do {
            let response: GenreResponse = try await apiService.fetch(APIEndpoint.genres.path)
            XCTAssertEqual(response.genres.count, 1)
            XCTAssertEqual(response.genres.first?.name, "Action")
        } catch {
            XCTFail("Expected success, but got error: \(error)")
        }
    }
    
    func testFetchGenresFailure() async {
        apiService.mockError = APIError.invalidResponse
        
        do {
            let response: GenreResponse = try await apiService.fetch(APIEndpoint.genres.path)
            XCTFail("Expected failure, but got success")
        } catch {
            XCTAssertTrue(error is APIError)
        }
    }
}
