//
//  ViewController.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 11.09.2023.
//

import UIKit
import CoreApi

// HomePresenter -> HomeViewInterface 

protocol HomeViewInterface: AnyObject {
    //Presenter'ın View'e erişmesini istediğimiz metotları açacağız
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
    func endRefreshing()
    func prepareCollectionView()
    func addRefreshControl()
}

class HomeViewController: UIViewController, LoadingShowable {
    
    @IBOutlet private weak var restaurantsCollectionView: UICollectionView!
    
    var presenter: HomePresenterInterface!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
        
    @objc
    private func pullToRefresh() {
        presenter.pullToRefresh()
    }
    

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: RestaurantCollectionViewCell.self, indexPath: indexPath)
        //cell configure
        if let restaurant = presenter.restaurant(indexPath.item) {
            cell.viewModel = RestaurantCollectionViewCellViewModel(restaurant: restaurant)
        }
        
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.calculateCellSize(collectionViewWidth: Double(collectionView.frame.size.width))
           return .init(width: size.width, height: size.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: .zero, left: CGFloat(presenter.cellPadding), bottom: .zero, right: CGFloat(presenter.cellPadding))
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.willDisplay(indexPath.item)
        
        
    }
}

extension HomeViewController: HomeViewInterface {
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func reloadData() {
        restaurantsCollectionView.reloadData()
    }
    
    func endRefreshing() {
        restaurantsCollectionView.refreshControl?.endRefreshing()
    }
    
    func prepareCollectionView() {
        restaurantsCollectionView.dataSource = self
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.register(cellType: RestaurantCollectionViewCell.self)
    }
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        restaurantsCollectionView.refreshControl = refreshControl
    }


    
    
}
