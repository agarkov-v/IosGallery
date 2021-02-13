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
    
    var presenter: GalleryPresenter!
    private var searchController = UISearchController(searchResultsController: nil)
    private var currentIndexPath: IndexPath?
    private var searchText: String?
    //second variant
    //    private var searchController: UISearchController {
    //        let searchController = UISearchController()
    //        searchController.searchResultsUpdater = self
    //        searchController.delegate = self
    //        searchController.obscuresBackgroundDuringPresentation = false
    //        return searchController
    //    }
    
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return refreshControl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GalleryConfigurator().configure(view: self)
        collectionView.refreshControl = refreshControl
        registerNib()
        createSearchBar()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareView()
        //        setupTitleNavigationBar(entity: .accountGallery)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupTitleNavigationBar("")
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
    
    @IBAction func changeType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presenter.changeSegmant(index: 0, searchText: searchText)

        case 1:
            presenter.changeSegmant(index: 1, searchText: searchText)
            
        default:
            debugPrint("changeType segmentControl default case")
        }

//        if segment.selectedSegmentIndex == 0 {
//             presenter.changeSegmant(index: 0, searchText: searchText)
//        } else {
//              presenter.changeSegmant(index: 1, searchText: searchText)
//        }
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
    
    @objc func reloadData() {
        presenter.reloadData(searchBy: searchText)
    }
}

extension GalleryViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath.row)
    }
}

extension GalleryViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.galleryItemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.galleryCell, for: indexPath)!

        let visibles = collectionView.indexPathsForVisibleItems.sorted()
        if !visibles.isEmpty {
            self.currentIndexPath = visibles[visibles.count / 2]
        }

        if indexPath.row > self.presenter.galleryItemsCount - 3 {
            self.presenter.loadData(searchBy: searchText)
        }
        presenter.setupCell(cell: cell, index: indexPath.row)
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
    
    func reloadCollection() {
        self.collectionView.reloadData()
    }
    
    func endRefreshing() {
        self.collectionView.refreshControl?.endRefreshing()
    }

    func showLoaderView() {
        collectionView.stubLoading()
    }

    func showEmptyMessage(_ stubType: StubType) {
        collectionView.stubView(stubType: stubType)
    }

    func clearBackgroundView() {
        collectionView.hideEmptyMessage()
    }
}

extension GalleryViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
//            presenter.reset()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.presenter.loadData(searchBy: searchText.trimmingCharacters(in: .whitespaces))
                self.searchText = searchText
//            })
//            self.presenter.loadData(searchBy: searchText.trimmingCharacters(in: .whitespaces))
//            self.searchText = searchText
        } else {
            self.searchText = nil
//            self.presenter.reset()
            self.presenter.loadData(searchBy: nil)
        }
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        self.searchText = nil
//        self.presenter.reset()
        self.presenter.loadData(searchBy: nil)
    }
    
}

extension GalleryViewController: UISearchControllerDelegate {
    
}

extension GalleryViewController: ScrollableToTop {
    func scrollToTop() {
        self.collectionView.scrollToTop(true)
    }
}
