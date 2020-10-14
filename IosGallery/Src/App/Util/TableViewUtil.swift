//
//  TableViewUtil.swift
//  IosGallery
//
//  Created by Вячеслав Агарков on 14.10.2020.
//

import UIKit

extension UITableView {
    func addTopBounceAreaView(color: UIColor = .white) {
        var frame = UIScreen.main.bounds
        frame.origin.y = -frame.size.height

        let view = UIView(frame: frame)
        view.backgroundColor = color

        self.addSubview(view)
    }
    
    func removeSeparatorsOfEmptyCells() {
        tableFooterView = UIView(frame: .zero)
    }

    func removeSeparatorsOfEmptyCellsAndLastCell() {
        tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 1)))
    }
    
    func removeHeaderSeparator() {
        tableHeaderView = UIView(frame: .zero)
    }
}
