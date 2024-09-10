//
//  SearchBarExtension.swift
//  MVP
//
//  Created by Nikita Beglov on 08.07.2024.
//

import UIKit

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            presenter?.getFilms()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
    }
}

