//
//  ColorView.swift
//  Journal
//
//  Created by Michael Folcher on 11/3/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import UIKit

protocol ColorViewDelegate: class {
    func selectColor(customColor: UIColor)
}

class ColorView: UIView {
    
    var isSelected = false
    var isSelectedView = UIView(frame: CGRect.zero)
    var delegate: ColorViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        CreateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CreateView()
    }
    
    func CreateView() {
        //Create the view as a circle
        let radius = max(frame.width, frame.height) / 2
        layer.cornerRadius = radius
        clipsToBounds = true
        backgroundColor = setupBackground()
        
        //Create the selected parts
        isSelectedView.frame = CGRect(x: 10.0, y: 10.0, width: frame.width - 20.0, height: frame.height - 20.0)
        let selectedRadius = max(isSelectedView.frame.width, isSelectedView.frame.height) / 2.0
        isSelectedView.layer.cornerRadius = selectedRadius
        isSelectedView.clipsToBounds = true
        isSelectedView.backgroundColor = .black
        isSelectedView.alpha = isSelected ? 0.5 : 0.0
        
        addSubview(isSelectedView)
        setupTap()
    }
    
    func setupBackground() -> UIColor {
        switch tag {
        case 1:
            return .red
        case 2:
            return .orange
        case 3:
            return .yellow
        case 4:
            return .green
        case 5:
            return .blue
        case 6:
            return .purple
        case 7:
            return .gray
        default:
            return .white
        }
    }
    
    func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectColor))
        addGestureRecognizer(tap)
    }
    
    @objc func selectColor() {
        delegate?.selectColor(customColor: setupBackground())
        toggle()
    }
    
    func toggle() {
        isSelected = !isSelected
        isSelectedView.alpha = isSelected ? 0.5 : 0.0
        
    }
    
}
