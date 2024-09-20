//
//  HomeView.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var vm: HomeViewModel
    @State private var showDetailsView: Bool = false

    init() {
        _vm = StateObject(wrappedValue: HomeViewModel(dataService: RepositoryDataService()))
    }

    var body: some View {
        ScrollView {
            ForEach(vm.repositoryList) { repository in
                LazyVStack{
                    RepositoryViewCard(repository: repository)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                        )
                }
                .onTapGesture {
                    showDetailsView.toggle()
                }
            }
        }.padding(.horizontal)
            .navigationTitle("GitHub Repositories")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }

}
