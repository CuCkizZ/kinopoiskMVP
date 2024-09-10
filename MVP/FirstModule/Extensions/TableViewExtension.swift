//
//  TableViewExtension.swift
//  MVP
//
//  Created by Nikita Beglov on 08.07.2024.
//

import UIKit

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filmId = presenter?.film(at: indexPath.row).filmId else { return }
        presenter?.presentDetailVC(filmId: filmId)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.numbersOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowInSections(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let film = presenter?.film(at: indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell",
                                                       for: indexPath) as? MainTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configuration(with: film)
        return cell
    }
}
