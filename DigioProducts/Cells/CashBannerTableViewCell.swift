//
//  CashBannerTableViewCell.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 15/09/24.
//

import UIKit

class CashBannerCellController: CellController {
    
    private var cash: Cash
    private var callback: (Cash) -> Void
    
    init(cash: Cash, action: @escaping (Cash) -> Void) {
        self.cash = cash
        self.callback = action
    }
    
    override func configure(cell: UITableViewCell) -> UITableViewCell {
        (cell as? CashBannerTableViewCell)?.configure(with: cash)
        return cell
    }
    
    override func didSelect() {
        callback(cash)
    }
}

class CashBannerTableViewCell: CellView {
    
    @IBOutlet private weak var cashBanner: ServiceView?
    
    fileprivate func configure(with cash: Cash){
        cashBanner?.configure(with: cash)
    }
    
}
