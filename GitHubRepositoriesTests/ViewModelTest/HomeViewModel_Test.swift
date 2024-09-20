//
//  HomeViewModel_Test.swift
//  GitHubRepositoriesTests
//
//  Created by Farido on 20/09/2024.
//

import XCTest
import Combine
@testable import GitHubRepositories


final class HomeViewModel_Test: XCTestCase {

    private var homeViewModel: HomeViewModel!
    private var dataService: RepositoryDataServiceClient!
    private var cancellable = Set<AnyCancellable>()

    private var filename = "Repository"

    override func setUp() {
        super.setUp()
        dataService = RepositoryDataServiceClient(filename: filename)
        homeViewModel = HomeViewModel(dataService: dataService)
    }

    override func tearDown() {
        homeViewModel = nil
        dataService = nil
        super.tearDown()
    }

    func testFetchProducts_DecodesJSONFileCorrectly() {
        let expectation = XCTestExpectation(description: "Fetch products and decode JSON")
        dataService.getRepositories()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { repositories in
                XCTAssertEqual(repositories.count, 2, "Expected to decode 2 products.")
                XCTAssertEqual(repositories[0].name ?? "", "grit")
                expectation.fulfill()
            })
            .store(in: &cancellable)

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
}

