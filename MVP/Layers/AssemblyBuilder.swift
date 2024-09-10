//
//  Builder.swift
//  MVP
//
//  Created by Nikita Beglov on 29.05.2024.
//

import UIKit

protocol AssemblyProtocol {
    func setupRootController(router: RouterProtocol) -> UIViewController
    func setupDetailController(filmId: Int, router: RouterProtocol) -> UIViewController
}

final class AssemblyBuilder: AssemblyProtocol {

    func setupRootController(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let searchController = view.searchController
        let networkService: NetworkServiceProtocol = NetworkService()
        let presenter: MainPresenterProtocol = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        view.searchController = searchController
        return view
    }

    func setupDetailController(filmId: Int, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService: NetworkServiceProtocol = NetworkService()
        let presenter: DetailPresenterProtocol = DetailPresenter(view: view, networkService: networkService, router: router, filmId: filmId)
        view.presenter = presenter
        return view
    }
}
