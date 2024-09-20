//
//  RepositoryDataServiceClient.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import XCTest
import Combine
@testable import GitHubRepositories

final class RepositoryDataServiceClient:  RepositoryDataServiceProtocol, Mockable {

    let filename: String

    init(filename: String) {
        self.filename = filename
    }

    func getRepositories() -> AnyPublisher<[RepositoryElement], Error> {
        return loadJson(filename: filename, extensionType: .json, responseModel: [RepositoryElement].self)
    }
  
}

