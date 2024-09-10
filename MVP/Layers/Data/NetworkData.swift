//
//  NetworkData.swift
//  MVP
//
//  Created by Nikita Beglov on 07.07.2024.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let preview = try? JSONDecoder().decode(Preview.self, from: jsonData)

// MARK: - Preview
struct Movies: Codable {
    let keyword: String?
    let pagesCount, searchFilmsCountResult: Int?
    let films: [Films]
}
    struct Films: Codable {
        let filmId: Int
        let nameRu, nameEn, type, year: String?
        let description, filmLength: String?
        let countries: [Country]
        let genres: [Genre]
        let rating: String?
        let ratingVoteCount: Int
        let posterURL: String?
        let posterUrlPreview: String?
    }

// MARK: - Country
struct Country: Codable {
    let country: String
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}
