//
//  NetworkService.swift
//  MVP
//
//  Created by Nikita Beglov on 29.05.2024.
//

import UIKit

protocol NetworkServiceProtocol {
    func getFilms(keyword: String, completion: @escaping ([Films]) -> Void)
    func getInfo(filmId: Int, completion: @escaping (FullInfo) -> Void)
    func makeMostRequest(completion: @escaping ([Films]) -> (Void))
    //func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private var mapper = Mapper()
    
    func getFilms(keyword: String, completion: @escaping ([Films]) -> Void) {
        let urlString = NetworkConstants.UrlString.filmRequest + keyword
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [NetworkConstants.HttpHeader.apiHeader : NetworkConstants.HttpHeader.apiKey]
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print("Download data error")
                return
            }
            if let data = data {
                do {
                    let jsonDecoder = try JSONDecoder().decode(Movies.self, from: data)
                    completion(jsonDecoder.films)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getInfo(filmId: Int, completion: @escaping (FullInfo) -> Void) {
        let urlString = NetworkConstants.UrlString.filmDescriptionRequest + String(filmId)
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [NetworkConstants.HttpHeader.apiHeader : NetworkConstants.HttpHeader.apiKey]
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print("Download data error")
                return
            }
            if let data = data {
                do {
                    let preview = try JSONDecoder().decode(Preview.self, from: data)
                    let fullInfo = self.mapper.mapping(preview)
                    completion(fullInfo)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func makeMostRequest(completion: @escaping ([Films]) -> Void) {
        let urlString = NetworkConstants.UrlString.mostFilmRequest
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [NetworkConstants.HttpHeader.apiHeader : NetworkConstants.HttpHeader.apiKey]
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil else {
                print("Download data error")
                return
            }
            if let data = data {
                do {
                    let jsonDecoder = try JSONDecoder().decode(Movies.self, from: data)
                    completion(jsonDecoder.films)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
//    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
//        //guard let url = url else { return }
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//            completion(UIImage(data: data))
//        }.resume()
//    }
//}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

private enum NetworkConstants {
    
    enum UrlString {
        static let filmRequest: String = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword="
        static let mostFilmRequest: String = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS"
        static let filmDescriptionRequest: String = "https://kinopoiskapiunofficial.tech/api/v2.2/films/"
    }
    
    enum HttpHeader {
        static let apiHeader: String = "X-API-KEY"
        static let apiKey: String = "48be9be7-345d-4446-8f35-39a4ac9dc3cd"
    }
}
