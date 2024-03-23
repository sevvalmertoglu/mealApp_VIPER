//
//  HomeInteractor.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 3.03.2024.
//

import Foundation
import CoreApi

// HomePresenter -> HomeInteractorInterface
protocol HomeInteractorInterface {
    //Presenter'ın Interactor'dan erişmesini istediğimiz metotları yazacağız
    func fetchWidgets(query:String)
}

//HomeInteractorOutput -> HomePresenter (Servisin sonuçlarını Presenter'a haber verir)
protocol HomeInteractorOutput: AnyObject {
    func handleWidgetResult( result:WidgetResult, query:String)
    
}

typealias WidgetResult = Result<HomeResponse, APIClientError>

final class HomeInteractor {
    private let networkManager: NetworkManager<HomeEndpointItem>
    weak var output: HomeInteractorOutput?
    
    init(networkManager: NetworkManager<HomeEndpointItem> = NetworkManager()) {
        self.networkManager = networkManager
    }
    
}

extension HomeInteractor: HomeInteractorInterface {
    func fetchWidgets(query: String) {
        networkManager.request(endpoint: .homepage(query: query), type: HomeResponse.self) { [weak self] result in
            
            self?.output?.handleWidgetResult(result: result, query: query)
           
        }
        
        
    }
}
