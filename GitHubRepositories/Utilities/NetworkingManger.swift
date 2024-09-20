//
//  NetworkingManger.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import Foundation
import SwiftUI
import Combine

enum NetworkingError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case custom(error: Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidResponse:
            return "The server responded with an invalid response."
        case .decodingError:
            return "Failed to decode the data."
        case .custom(let error):
            return error.localizedDescription
        }
    }
}

class NetworkingManger {

    static func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        print(url)
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLResponse(response: $0, url: url)})
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError(handleError)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    static func fetchImages(url: URL) -> AnyPublisher<Data, Error> {
        print(url)
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLResponse(response: $0, url: url)})
            .mapError(handleError)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    static func handleURLResponse(response: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkingError.invalidResponse
        }
        return response.data
    }

    static func handleError(error: Error) -> NetworkingError {
        return error as? NetworkingError ?? NetworkingError.custom(error: error)
    }
}
