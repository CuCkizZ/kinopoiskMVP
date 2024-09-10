//
//  MainPresenterProtocol.swift
//  MVP
//
//  Created by Nikita Beglov on 08.07.2024.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func getFilms()
    func getStarts()
    func numbersOfSections() -> Int
    func numberOfRowInSections(_ section: Int) -> Int
    func heightForARow() -> CGFloat
    func presentDetailVC(filmId: Int)
    func film(at row: Int) -> CellModel
}
