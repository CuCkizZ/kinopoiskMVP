//
//  MainPresenter.swift
//  MVP
//
//  Created by Nikita Beglov on 29.05.2024.
//

import Foundation
import UIKit

final class MainPresenter: MainPresenterProtocol {
    
    private var router: RouterProtocol
    private var networkService: NetworkServiceProtocol
    private weak var view: MainViewProtocol?
    private var model: [Films]?
    var cellDataSource: [CellModel] = []
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getStarts()
    }
    
    // MARK: API
    
    func getStarts() {
        networkService.makeMostRequest { [weak self] films in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.model = films
                self.mpCell()
                self.view?.reloadTable()
            }
        }
    }
    
    func getFilms() {
        networkService.getFilms(keyword: view?.setKeyword() ?? "") { [weak self] films in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.model = films
                self.mpCell()
                self.view?.reloadTable()
            }
        }
    }
    
    // MARK: Mapping
    
    private func mpCell() {
        if let model = model {
            cellDataSource = model.compactMap { CellModel(model: $0) }
        } else {
            cellDataSource = []
        }
    }
    
//    MARK: UIViewControllerSetup
    
    func presentDetailVC(filmId: Int) {
        if let view = view as? UIViewController {
            router.modalPresent(from: view, filmId: filmId)
        }
    }
    
    func film(at row: Int) -> CellModel {
        return cellDataSource[row]
    }
    
    func numbersOfSections() -> Int {
        1
    }
    
    func numberOfRowInSections(_ section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func heightForARow() -> CGFloat {
        150
    }
}

