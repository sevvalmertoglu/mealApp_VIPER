//
//  HomeRouter.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 3.03.2024.
//

import Foundation
import UIKit

//HomePresenter ->  HomeRouterInterface
protocol HomeRouterInterface {
    
}

final class HomeRouter {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> HomeViewController? {
        //Bağlantıları sağlamış olduk
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor)
        view?.presenter = presenter
        interactor.output = presenter
        return view
    }
}

