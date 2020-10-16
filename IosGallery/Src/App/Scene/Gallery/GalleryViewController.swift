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
    private var currentIndexPath: IndexPath?
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
        registerNib()
        createSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
//        setupTitleNavigationBar(entity: .accountGallery)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if self.view.window != nil {
            self.collectionView.collectionViewLayout.invalidateLayout()
            if let indexPath = self.currentIndexPath {
                DispatchQueue.main.async {
                    self.collectionView.scrollToItem(at: indexPath,
                                                     at: .centeredVertically,
                                                     animated: false)
                }
            }
        }
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
    
    func registerNib() {
        let galletyNib = R.nib.galleryCell
        collectionView.register(galletyNib)
    }
    
    func collectionCellSize(noOfCellsInRow: Int, leftSectionInset: CGFloat, rightSectionInset: CGFloat, minInteritemSpacing: CGFloat) -> Int {
        let minInteritemSpacing = minInteritemSpacing * CGFloat((noOfCellsInRow - 1))
        let totalSpace = (leftSectionInset + rightSectionInset + minInteritemSpacing)
        let cellSize = (Int(collectionView.bounds.width) - Int(totalSpace)) / noOfCellsInRow
        return cellSize
    }

}

extension GalleryViewController: UICollectionViewDelegate {
    
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.galleryCell.identifier, for: indexPath) as! GalleryCell
        let visibles = collectionView.indexPathsForVisibleItems.sorted()
        if !visibles.isEmpty {
            self.currentIndexPath = visibles[visibles.count / 2]
        }
        cell.galleryImageView.image = R.image.testPlaceholderImage()
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftInset = CGFloat(16)
        let rightSectionInset = CGFloat(16)
        let minInteritemSpacing = CGFloat(10)
        if UIDevice.current.orientation.isLandscape {
            let cellSize = collectionCellSize(noOfCellsInRow: 3, leftSectionInset: leftInset, rightSectionInset: rightSectionInset, minInteritemSpacing: minInteritemSpacing)
            return CGSize(width: cellSize, height: cellSize)
        }
        let cellSize = collectionCellSize(noOfCellsInRow: 2, leftSectionInset: leftInset, rightSectionInset: rightSectionInset, minInteritemSpacing: minInteritemSpacing)
        return CGSize(width: cellSize, height: cellSize)

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
