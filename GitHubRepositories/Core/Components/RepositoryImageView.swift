//
//  RepositoryImageView.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import SwiftUI

struct RepositoryImageView: View {
    @StateObject var vm: RepositoryImageViewModel

    init(url: String, imageName: String) {
        _vm = StateObject(wrappedValue: RepositoryImageViewModel(url: url, imageName: imageName))
    }

    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .clipShape(Circle())
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(.secondary)

            }
        }
    }
}

struct RepositoryImageView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryImageView(url: "https://avatars.githubusercontent.com/u/1?v=4", imageName: "MDQ6VXNlcjE=")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
