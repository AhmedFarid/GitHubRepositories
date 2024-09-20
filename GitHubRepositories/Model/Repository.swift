//
//  Repository.swift
//  GitHubRepositories
//
//  Created by Farido on 20/09/2024.
//

import Foundation


struct RepositoryElement: Codable, Identifiable {
    let id: Int?
    let name: String?
    let fullName: String?
    let repositoryPrivate: Bool?
    let owner: Owner?
    let description: String?
    let fork: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case repositoryPrivate = "private"
        case owner = "owner"
        case description = "description"
        case fork = "fork"
    }



    var createdDate: String? {
        return formattedDate(from: randomDateWithinLastThreeYears())
    }

    func randomDateWithinLastThreeYears() -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        guard let threeYearsAgo = calendar.date(byAdding: .year, value: -3, to: currentDate) else {
            return Date()
        }
        let timeInterval = currentDate.timeIntervalSince(threeYearsAgo)
        let randomTimeInterval = TimeInterval(arc4random_uniform(UInt32(timeInterval)))
        return threeYearsAgo.addingTimeInterval(randomTimeInterval)
    }

    func formattedDate(from date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        if let monthsDifference = calendar.dateComponents([.month], from: date, to: now).month {
            if monthsDifference < 6 {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, MMM dd, yyyy"
                return dateFormatter.string(from: date)
            } else {
                let componentsFormatter = DateComponentsFormatter()
                componentsFormatter.unitsStyle = .full
                componentsFormatter.maximumUnitCount = 1
                componentsFormatter.allowedUnits = [.year, .month]
                return componentsFormatter.string(from: date, to: now) ?? "Unknown date"
            }
        }
        return "Unknown date"
    }
}

struct Owner: Codable {
    let login: String?
    let id: Int?
    let avatarUrl: String?

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case avatarUrl = "avatar_url"
    }
}
