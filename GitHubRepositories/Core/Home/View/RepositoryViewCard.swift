//
//  RepositoryViewCard.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import SwiftUI

struct RepositoryViewCard: View {
    let repository: RepositoryElement

    var body: some View {

        HStack(alignment: .center, spacing: 12) {
            RepositoryImageView(url: repository.owner?.avatarUrl ?? "", imageName: "\(repository.owner?.id ?? 0)")
                .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: 4) {
                Text(repository.name ?? "")
                    .font(.headline)
                    .bold()

                Text(repository.description ?? "")
                    .font(.caption)
                    .bold()
                    .lineLimit(3)

                Text("Created at: \(repository.createdDate ?? "")")
                    .font(.caption)
                    .bold()
                    .lineLimit(3)
            }

            Spacer()
        }
        .padding()

    }
}

#Preview {
    RepositoryViewCard(repository: RepositoryElement(id: 1, name: "name", fullName: "full name", repositoryPrivate: true, owner: Owner(login: "mojombo", id: 1, avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"), description: "description", fork: false))
}
