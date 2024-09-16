//
//  ProductListTableViewCell.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 15/09/24.
//

import UIKit

class ProductListCellController: CellController {
    
    private var list: [Product]
    private var callback: (Product) -> Void
    
    init(list: [Product], action: @escaping (Product) -> Void) {
        self.list = list
        self.callback = action
    }
    
    override func configure(cell: UITableViewCell) -> UITableViewCell {
        (cell as? ProductListTableViewCell)?.configure(with: list, 
                                                       callback: callback)
        return cell
    }
}

class ProductListTableViewCell: CellView {

    private var callback: ((Product) -> Void)?
    private var list: [Product]? {
        didSet {
            guard let list = list else { return }
            configureViews(for: list)
        }
    }
    private var listView: [UIView] = []
    
    @IBOutlet private weak var carouselView: CarouselView?
    
    fileprivate func configure(with list: [Product], callback: @escaping (Product) -> Void) {
        self.callback = callback
        self.list = list
    }
    
    private func configureViews(for list: [Product]) {
        list.forEach { model in
            let productView = ProductView(product: model, callback: callback)
            listView.append(productView)
        }
            
        carouselView?.configure(with: listView)
    }
    
}
