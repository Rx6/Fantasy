//
//  UITableView+TCExtension.swift
//  TCExtension
//
//  Created by Tony on 2020/7/10.
//  Copyright © 2020 East. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    func update(_ block: @escaping (UITableView)->Void) {
        self.beginUpdates()
        block(self)
        self.endUpdates()
    }
    
    func scrollTo(row: Int, section: Int, postioin: UITableView.ScrollPosition, animated: Bool = true) {
        self.scrollToRow(at: IndexPath(row: row, section: section), at: postioin, animated: animated)
    }
    
    func insert(row: Int, section: Int, animation: UITableView.RowAnimation = .automatic) {
        self.insertRows(at: [IndexPath(row: row, section: section)], with: animation)
    }
    
    func reload(row: Int, section: Int, animation: UITableView.RowAnimation = .automatic) {
        self.reloadRows(at: [IndexPath(row: row, section: section)], with: animation)
    }
    
    func delete(row: Int, section: Int, animation: UITableView.RowAnimation = .automatic) {
        self.deleteRows(at: [IndexPath(row: row, section: section)], with: animation)
    }
    func insert(section: Int, animation: UITableView.RowAnimation) {
        self.insertSections(IndexSet([section]), with: animation)
    }
    func delete(section: Int, animation: UITableView.RowAnimation) {
        self.deleteSections(IndexSet([section]), with: animation)
    }
    func reload(section: Int, animation: UITableView.RowAnimation) {
        self.reloadSections(IndexSet([section]), with: animation)
    }
    func clearSelectedRows(_ animated: Bool = true) {
        if let indexs = self.indexPathsForVisibleRows, indexs.count > 0 {
            indexs.forEach({ (item) in
                self.deselectRow(at: item, animated: animated)
            })
        }
    }
}
