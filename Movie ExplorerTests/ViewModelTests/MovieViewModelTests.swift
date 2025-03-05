//
//  MovieViewModelTests.swift
//  Movie Explorer
//
//  Created by Moshiur Rahman on 5/3/25.
//

import XCTest
@testable import Movie_Explorer

@MainActor
class MovieViewModelTests: XCTestCase {

    var viewModel: MovieViewModel!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = MovieViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }

    func testFetchGenresSuccess() async {
        let mockResponse = """
        {
            "genres": [{"id": 1, "name": "Action"}]
        }
        """.data(using: .utf8)
        
        mockAPIService.mockData = mockResponse
        
        await viewModel.fetchGenres()
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.genres.count, 1)
        XCTAssertEqual(viewModel.genres.first?.name, "Action")
    }
    
    func testFetchGenresFailure() async {
        mockAPIService.mockError = APIError.invalidResponse

        await viewModel.fetchGenres()

        XCTAssertFalse(viewModel.isLoading, "Loading state should be false after the API call finishes.")
        
        XCTAssertNotNil(viewModel.errorMessage, "Error message should be set when the fetch fails.")
    }
    
    func testFetchMovieDetailsFailure() async {
        mockAPIService.mockError = APIError.invalidResponse
        
        await viewModel.fetchMovieDetails(for: 1)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.movie)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
