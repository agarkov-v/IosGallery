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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeSeparatorsOfEmptyCells()
        configureBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    }
    
    

}

extension AccountViewController: UITableViewDelegate {
    
}

extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
}
