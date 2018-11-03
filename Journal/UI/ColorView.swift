//
//  ColorView.swift
//  Journal
//
//  Created by Michael Folcher on 11/3/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import UIKit

class ColorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CreateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CreateView()
    }
    
    func CreateView() {
        let radius = max(frame.width, frame.height) / 2
        layer.cornerRadius = radius
        clipsToBounds = true
        backgroundColor = .red
    }
}
