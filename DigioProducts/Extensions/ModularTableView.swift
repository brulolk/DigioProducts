//
//  ModularTableView.swift
//  DigioProducts
//
//  Created by Bruno Vinicius on 14/09/24.
//

import UIKit

class ModularTableView: UITableView {
    
    var sections: [[CellController]] = []
    var sectionsView: [CellController] = []
    
    var cellControllers:[CellController] = [] {
        didSet {
            
            if cellControllers.contains(where: { $0.isPinned == true } ) && (cellControllers.first?.isPinned == false) {
                let spacingCell = SpacingCellController(height: 0)
                spacingCell.isPinned = true
                cellControllers.insert(spacingCell, at: 0)
            }
            
            var countAdjusts = 1
            var vec: [CellController] = []
            for (index, cell) in cellControllers.dropLast().enumerated() {
                if vec.isEmpty {
                    vec.append(cell)
                } else if vec.last!.isPinned && cell.isPinned {
                    let spacingCell = SpacingCellController(height: 0)
                    spacingCell.isPinned = false
                    cellControllers.insert(spacingCell, at: index+countAdjusts)
                    countAdjusts += 1
                }
                vec.append(cell)
            }
            
            
            cellControllers.forEach { ( $0.tableview = self ) }
            
            sectionsView = cellControllers.filter { $0.isPinned == true }
            sections = cellControllers.split(whereSeparator: { $0.isPinned }).map { Array($0) }
            
            self.dataSource = self
            self.delegate = self
            self.reloadData()
        }
    }
    
}

extension ModularTableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section][indexPath.row].cell(indexPathAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section][indexPath.row].heightController()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[indexPath.section][indexPath.row].didSelect()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < sectionsView.count else {
            return nil
        }
        return sectionsView[section].section(sectionAt: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section < sectionsView.count else {
            return 0
        }
        return sectionsView[section].heightController()
    }

        
}
