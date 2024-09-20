//
//  HomeViewModel.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    private let dataService: RepositoryDataServiceProtocol
    private var cancellable = Set<AnyCancellable>()

    @Published var repositoryList: [RepositoryElement] = []
    @Published var selectedRepository: RepositoryElement? = nil
    @Published var errorMessage: String?


    init(dataService: RepositoryDataServiceProtocol) {
        self.dataService = dataService
        getRepository()
    }

    func getRepository()  {
        dataService.getRepositories()
            .sink { [weak self] completion in
                guard let self = self else {return}
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] repository in
                guard let self = self else {return}
                self.repositoryList = repository
            }
            .store(in: &cancellable)
    }

    
}
