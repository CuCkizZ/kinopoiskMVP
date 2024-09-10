//
//  DetailPresenter.swift
//  MVP
//
//  Created by Nikita Beglov on 29.05.2024.
//

import Foundation

final class DetailPresenter: DetailPresenterProtocol {
    
    private weak var view: DetailViewProtocol?
    private var networkService: NetworkServiceProtocol
    private var router: RouterProtocol
    private var filmId: Int
    private var model: FullInfo?
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, filmId: Int) {
        self.view = view
        self.router = router
        self.networkService = networkService
        self.filmId = filmId
        getfilmDescription()
    }

    private func getfilmDescription() {
        networkService.getInfo(filmId: filmId, completion: { [weak self] filmDescription in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.view?.configure(filmDescription)
            }
        })
    }
}
