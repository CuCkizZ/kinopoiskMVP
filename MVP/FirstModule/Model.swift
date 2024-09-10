//
//  MainModel.swift
//  MVP
//
//  Created by Nikita Beglov on 29.05.2024.
//

import Foundation

struct CellModel {
    var filmId: Int
    var title: String?
    var posterImage: URL?
    
    init(model: Films) {
        self.filmId = model.filmId
        self.title = model.nameRu ?? model.nameEn ?? "na name"
        guard let poseterImage = model.posterUrlPreview else { return }
        self.posterImage = URL(string: poseterImage)
    }
}
