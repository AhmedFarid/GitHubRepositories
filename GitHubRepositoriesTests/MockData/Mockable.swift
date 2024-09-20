//
//  Mockable.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import Foundation
import Combine
@testable import GitHubRepositories

enum FileExtensionType: String {
    case json = ".json"
}

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJson<T: Decodable>(filename: String,
                                extensionType: FileExtensionType,
                                responseModel: T.Type) -> AnyPublisher<T, Error>
}

extension Mockable {

    var bundle: Bundle {
        Bundle(for: type(of: self))
    }

    func loadJson<T: Decodable>(filename: String,
                                extensionType: FileExtensionType,
                                responseModel: T.Type) -> AnyPublisher<T, Error> {

        guard let path = bundle.url(forResource: filename,
                                    withExtension: extensionType.rawValue) else {
            return Fail(error: NetworkingError.invalidURL)
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: path)
            .map {$0.data}
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
