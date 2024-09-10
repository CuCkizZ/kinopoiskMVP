//
//  DetailPresenterProtocol.swift
//  MVP
//
//  Created by Nikita Beglov on 08.07.2024.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, filmId: Int)
}
