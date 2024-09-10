//
//  Router.swift
//  MVP
//
//  Created by Nikita Beglov on 01.07.2024.
//

import Foundation
import UIKit

protocol DefaulRouter: AnyObject {
    var navigationController: UINavigationController? { get set }
    var assembly: AssemblyProtocol? { get set }
}

protocol RouterProtocol: DefaulRouter {
    func initialViewController()
    func presentDetailVC(filmId: Int)
    func modalPresent(from: UIViewController, filmId: Int)
    func popToRoot()
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assembly: AssemblyProtocol?
    
    init(navigationController: UINavigationController, assembly: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assembly?.setupRootController(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func presentDetailVC(filmId: Int) {
        if let navigationController = navigationController {
            guard let detailViewController = assembly?.setupDetailController(filmId: filmId, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func modalPresent(from: UIViewController, filmId: Int) {
        guard let detailViewController = assembly?.setupDetailController(filmId: filmId, router: self) else { return }
        from.present(detailViewController, animated: true)
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
}
    
    // MARK: Plan B
    //    var moduleBuilder =  AssemblyBuilder()
    //    weak var view: UIViewController?
    //
    //    func present(_ view: UIViewController, animated: Bool, filmId: Int,  completion: (() -> Void)?) {
    //        let dvc = ModuleBuilder.setupDetailController(filmId: filmId)
    //        self.view?.present(dvc, animated: true, completion: completion)
    //    }
