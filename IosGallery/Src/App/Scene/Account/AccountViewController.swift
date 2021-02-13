//
//  AccountViewController.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 13.10.2020.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    lazy private var refreshControl = UIRefreshControl()
    var presenter: AccountPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AccountConfigurator().configure(view: self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        registerNib()
        configureBarButtonItem()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleNavigationBar(entity: .accountGallery)
        tableView.removeSeparatorsOfEmptyCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupTitleNavigationBar("")
    }
    
    func configureBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(image: R.image.settingsGear(), style: .plain, target: self, action: #selector(onRightBarButtonItem))
        rightBarButtonItem.tintColor = R.color.pink()
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc private func reloadData() {
        presenter.reloadData()
    }
    
    @objc func onRightBarButtonItem() {
        print("onRightBarButtonItem click")
        presenter.openAccountSettings()
    }
    
    func registerNib() {
        let accountNib = R.nib.accountCell
        tableView.register(accountNib)
    }

}

extension AccountViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectImage(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension AccountViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.galleryItemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.accountCell, for: indexPath)!
        presenter.setupCell(cell: cell, index: indexPath.row)
        return cell
    }
    
}

extension AccountViewController: AccountView {

    func reloadTable() {
        tableView.reloadData()
    }

    func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }

    func showLoaderView() {
        tableView.stubLoading()
    }

    func showEmptyMessage(_ stubType: StubType) {
        tableView.stubView(stubType: stubType)
    }

    func clearBackgroundView() {
        tableView.hideEmptyMessage()
    }

    func setupProfile(user: UserEntity) {
        userNameLabel.text = user.username
        birthdayLabel.text = DateFormatUtil.standartDateFormat(dateString: user.birthday)
    }
}

extension AccountViewController: ScrollableToTop {
    func scrollToTop() {
        self.tableView.scrollToTop(true)
    }
}
