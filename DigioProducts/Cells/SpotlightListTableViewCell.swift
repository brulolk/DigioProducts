//
//  SpotlightListTableViewCell.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 15/09/24.
//

import UIKit

class SpotlightListCellController: CellController {
    
    private var list: [Spotlight]
    private var callback: (Spotlight) -> Void
    
    init(list: [Spotlight], action: @escaping (Spotlight) -> Void) {
        self.list = list
        self.callback = action
    }
    
    override func configure(cell: UITableViewCell) -> UITableViewCell {
        (cell as? SpotlightListTableViewCell)?.configure(with: list, 
                                                         callback: callback)
        return cell
    }
}

class SpotlightListTableViewCell: CellView {
    
    private var callback: ((Spotlight) -> Void)?
    private var list: [Spotlight]? {
        didSet {
            guard let list = list else { return }
            configureViews(for: list)
        }
    }
    private var listView: [UIView] = []
    
    @IBOutlet private weak var carouselView: CarouselView?
    
    fileprivate func configure(with list: [Spotlight], callback: @escaping (Spotlight) -> Void) {
        self.callback = callback
        self.list = list
    }
    
    private func configureViews(for list: [Spotlight]) {
        list.forEach { model in
            let serviceView = ServiceView(spotlight: model, callback: callback)
            listView.append(serviceView)
        }
            
        carouselView?.configure(with: listView)
    }
}
