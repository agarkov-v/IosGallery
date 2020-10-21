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
    
    var presenter: AccountPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AccountConfigurator().configure(view: self)
        tableView.delegate = self
        tableView.dataSource = self
        registerNib()
        configureBarButtonItem()
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
        
    }
    
    func configureBarButtonItem() {
        let rightBarButtonItem = UIBarButtonItem(image: R.image.settingsGear(), style: .plain, target: self, action: #selector(onRightBarButtonItem))
        rightBarButtonItem.tintColor = R.color.pink()
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
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
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.accountCell.identifier, for: indexPath) as! AccountCell
        cell.accountImageView.image = R.image.testPlaceholderBlueSquare()!
        cell.nameLabel.text = "Test name"
        cell.descriptionLabel.text = "This is test description text. This is test description text. This is test description text. This is test description text."
        return cell
    }
    
    
}

extension AccountViewController: AccountView {
    
}
