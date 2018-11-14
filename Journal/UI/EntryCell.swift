//
//  EntryCell.swift
//  Journal
//
//  Created by Michael Folcher on 11/13/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func updateCell(with entry: Entry) {
        colorView.backgroundColor = entry.color
        titleLabel.text = entry.title
        bodyLabel.text = entry.body
        
    }
    
}
