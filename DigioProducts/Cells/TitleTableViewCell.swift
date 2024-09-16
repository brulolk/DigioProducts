//
//  TitleTableViewCell.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 15/09/24.
//

import UIKit

class TitleCellController: CellController {

    private let title: String
    
    init(title: String) {
        self.title = title
    }
    
    override func configure(cell: UITableViewCell) -> UITableViewCell {
        (cell as? TitleTableViewCell)?.configure(with: title)
        return cell
    }
    
}

class TitleTableViewCell: CellView {

    @IBOutlet weak var titleLabel: UILabel?
    
    func configure(with title: String) {
        titleLabel?.text = title
    }
    
}
