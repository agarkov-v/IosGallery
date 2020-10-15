//
//  GalleryViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var modeSegmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: GalleryPresenterProtocol!
    private var searchController = UISearchController(searchResultsController: nil)
    //second variant
//    private var searchController: UISearchController {
//        let searchController = UISearchController()
//        searchController.searchResultsUpdater = self
//        searchController.delegate = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        return searchController
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
    }
    
    func prepareView() {
        modeSegmentControl.setTitle("New".localization(), forSegmentAt: 0)
        modeSegmentControl.setTitle("Popular".localization(), forSegmentAt: 1)
    }
    
    func createSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search".localization()
        self.navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        
        //second variant
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//        self.navigationItem.searchController = self.searchController
    }

}

extension GalleryViewController: UICollectionViewDelegate {
    
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    
}

extension GalleryViewController: GalleryView {
    
}

extension GalleryViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    
}

extension GalleryViewController: UISearchControllerDelegate {
    
}
