//
//  DetailModel.swift
//  MVP
//
//  Created by Nikita Beglov on 29.05.2024.
//

import Foundation

struct FullInfo: Codable {
    let nameRu: String?
    let nameOriginal: String?
    let posterUrl: URL?
    let ratingKinopoisk: Double
    let ratingImdb: Double
    let year: Int
    let filmLength: Int
    let description: String
}
