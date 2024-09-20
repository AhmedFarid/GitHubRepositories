//
//  RepositoryDataService.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import Foundation
import Combine

protocol RepositoryDataServiceProtocol {
    func getRepositories() -> AnyPublisher<[RepositoryElement], Error>
}

class RepositoryDataService: RepositoryDataServiceProtocol {

    init() {}

    func getRepositories() -> AnyPublisher<[RepositoryElement], Error> {
        guard let url = URL(string: "https://api.github.com/repositories") else {
            return Fail(error: NetworkingError.invalidURL)
                .eraseToAnyPublisher()
        }
        return NetworkingManger.fetch(url: url)
            .eraseToAnyPublisher()
    }

}
