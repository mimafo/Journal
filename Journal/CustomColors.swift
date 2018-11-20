//
//  CustomColors.swift
//  Journal
//
//  Created by Michael Folcher on 11/12/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import UIKit

struct CustomColors {
    
    enum colorValue: Int {
        case white
        case red
        case orange
        case yellow
        case green
        case blue
        case purple
        case gray
    }
    
    static func getColor(color: colorValue) -> UIColor {
        switch color {
        case .blue:
            return .blue
        case .gray:
            return .gray
        case .green:
            return .green
        case .orange:
            return .orange
        case .purple:
            return .purple
        case .red:
            return .red
        case .white:
            return .white
        case .yellow:
            return .yellow
        }
    }
    
    static func getColorValue(color: UIColor) -> colorValue {
        switch color {
        case .blue:
            return .blue
        case .gray:
            return .gray
        case .green:
            return .green
        case .orange:
            return .orange
        case .purple:
            return .purple
        case .red:
            return .red
        case .white:
            return .white
        case .yellow:
            return .yellow
        default:
            return .white
        }
    }
    
}

/*
 
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
 */
