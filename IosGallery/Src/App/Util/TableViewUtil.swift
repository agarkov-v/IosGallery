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

        addSubview(view)
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
    
    func stubView(stubType: StubType? = nil, image: UIImage? = nil, title: String = "", message: String = "", take header: CGRect? = nil) {
        let sizes: CGSize = bounds.size
        let nib = R.nib.stubView
        guard let backgroundView = nib.instantiate(withOwner: nil)[0] as? StubView else { return }

        let rect = header != nil ? CGRect(x: 0,
                                          y: header!.maxY,
                                          width: sizes.width,
                                          height: sizes.height - header!.height) : CGRect(x: 0.0,
                                                                                          y: 0.0,
                                                                                          width: sizes.width,
                                                                                          height: sizes.height)

        let container = UIView(frame: CGRect(x: 0.0, y: 0.0, width: sizes.width, height: sizes.height))
        backgroundView.frame = rect
        container.addSubview(backgroundView)

        if let stubType = stubType {
            backgroundView.setup(stubType)
        } else {
            backgroundView.setup(image ?? R.image.notFoundPlaceholder()!, title, message)
        }
        self.backgroundView = container

        separatorStyle = .none
    }
    
    func stubLoading(take header: CGRect? = nil) {
        let sizes: CGSize = bounds.size
        let nib = R.nib.stubLoad
        guard let backgroundView = nib.instantiate(withOwner: nil)[0] as? StubLoad else { return }

        let rect = header != nil ? CGRect(x: 0,
                                          y: header!.maxY,
                                          width: sizes.width,
                                          height: sizes.height - header!.height) : CGRect(x: 0.0,
                                                                                          y: 0.0,
                                                                                          width: sizes.width,
                                                                                          height: sizes.height)

        let container = UIView(frame: CGRect(x: 0.0, y: 0.0, width: sizes.width, height: sizes.height))
        backgroundView.frame = rect
        container.addSubview(backgroundView)
        self.backgroundView = container

        separatorStyle = .none
    }

    func hideEmptyMessage() {
        backgroundView = nil
    }
}
