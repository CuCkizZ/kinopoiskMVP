//
//  MainViewControllerProtocol.swift
//  MVP
//
//  Created by Nikita Beglov on 08.07.2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func reloadTable()
    func setKeyword() -> String
}
