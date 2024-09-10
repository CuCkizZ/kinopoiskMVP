//
//  ViewController.swift
//  MVP
//
//  Created by Nikita Beglov on 29.05.2024.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController, UISearchResultsUpdating {
    
    var presenter: MainPresenterProtocol?
    var searchController = UISearchController(searchResultsController: nil)
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
    }
}

// MARK: MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func reloadTable() {
        tableView.reloadData()
    }
    
    func setKeyword() -> String {
        let keyword = searchController.searchBar.text ?? ""
        return keyword
    }
}

// MARK: Private Methods

private extension MainViewController {
    
    func setupViews() {
        view.addSubview(tableView)
        self.title = Constants.UIStringConstants.title
        navigationItem.searchController = searchController
        
        setupSearchController()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupSearchController() {
        searchController.searchBar.placeholder = Constants.UIStringConstants.searchPlaceholder
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
}

private enum Constants {
    enum TitleHeader {
        static let noReqest = "Фильмы"
        static let searchReqest = "Результат по запросу: "
        static let topRequest = "Популярные фильмы"
    }
    enum UIStringConstants {
        static let searchPlaceholder: String = "Введите запрос"
        static let title: String = "Фильмы"
    }
}

