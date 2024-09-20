//
//  RepositoryImageViewModel.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import Foundation
import SwiftUI
import Combine

class RepositoryImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
     
    private let dataService: AvatarImageServices
    private var cancellable = Set<AnyCancellable>()

    init(url: String, imageName: String) {
        self.dataService = AvatarImageServices(url: url, imageName: imageName)
        addSubscribers()
        isLoading = true
    }

    private func addSubscribers() {
        dataService.$image
            .sink {[weak self] (_) in
                guard let self = self else {return}
                self.isLoading = false
            } receiveValue: {[weak self] returnedImage  in
                guard let self = self else {return}
                self.image = returnedImage
            }
            .store(in: &cancellable)
    }
}
