//
//  AvatarImageServices.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import Foundation
import SwiftUI
import Combine

class AvatarImageServices {

    @Published var image: UIImage? = nil
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let url: String

    private let fileManager = LocalFileManger.instance
    private let folderName = "avatar_images"
    private let imageName: String

    init(url: String, imageName: String) {
        self.url = url
        self.imageName = imageName
        getAvatarImage()
    }

    private func getAvatarImage() {
        if let savedImage = fileManager.getImage(imageName: imageName , folderName: folderName) {
            image = savedImage
            print("Retrieved image form File Manger!")
        } else {
            downloadAvatarImage()
            print("Downloading image now")
        }
    }

    private func downloadAvatarImage() {
        guard let url = URL(string: url) else {
            self.errorMessage = NetworkingError.invalidURL.localizedDescription
            return
        }

        NetworkingManger.fetchImages(url: url)
            .tryMap { data -> UIImage? in
                return UIImage(data: data)
            }
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else {return}
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] (returnedImage) in
                guard let self = self else {return}
                guard let downloadedImage = returnedImage else {return}
                self.image = downloadedImage
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
            .store(in: &cancellables)
    }
}
