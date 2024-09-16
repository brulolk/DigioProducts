//
//  CellController.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import UIKit

class CellController {
    
    var isPinned: Bool = false
    
    var tableview: UITableView? {
        didSet {
            registerNib(for: tableview ?? UITableView())
        }
    }
    
    open var reuseIdentifier: String {
        return "\(type(of: self))".replacingOccurrences(of: "CellController", with: "TableViewCell")
    }
    
    func registerNib(for tableview: UITableView) {
        let className = reuseIdentifier
        let nib = UINib(nibName: className, bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: className)
    }
    
    func cell(indexPathAt: IndexPath) -> UITableViewCell {
        guard let cell = tableview?.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            return UITableViewCell()
        }
        (cell as? CellView)?.controller = self
        return configure(cell: cell)
    }
    
    func configure(cell: UITableViewCell) -> UITableViewCell {
        return cell
    }
    
    func section(sectionAt: Int) -> UIView {
        guard let view = tableview?.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            return UIView()
        }
        return configure(cell: view).contentView
    }
    
    func heightController() -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func didSelect() {
        //stub
    }
}

class CellView: UITableViewCell {
    
    weak var controller: CellController?
    
}
