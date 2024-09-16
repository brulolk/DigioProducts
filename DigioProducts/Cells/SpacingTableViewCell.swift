//
//  SpacingTableViewCell.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import UIKit

class SpacingCellController: CellController {

    var height: CGFloat?
    
    init(height: CGFloat) {
        self.height = height
    }
    
    override func heightController() -> CGFloat {
        return height ?? UITableView.automaticDimension
    }
    
}

private class SpacingTableViewCell: CellView {
    
}
