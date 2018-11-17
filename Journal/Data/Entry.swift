//
//  Entry.swift
//  Journal
//
//  Created by Michael Folcher on 11/4/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import UIKit

struct Entry: Codable {
    var title: String
    var body: String
    var tag: String
    var color: UIColor
    
    enum CodingKeys: String, CodingKey
    {
        case title
        case body
        case tag
        case color
    }
    
    mutating func update(title: String? = nil,
                body: String? = nil,
                tag: String? = nil,
                color: UIColor? = nil) {
        if let title = title {
            self.title = title
        }
        if let body = body {
            self.body = body
        }
        if let tag = tag {
            self.tag = tag
        }
        if let color = color {
            self.color = color
        }
    }
}

extension Entry: Equatable {
    static func ==(left: Entry, right: Entry) -> Bool {
        print("Left: \(left)")
        print("Right: \(right)")
        return left.title == right.title
            && left.body == right.body
            && left.tag == right.tag
            && left.color.isEqual(right.color)
    }
}

extension Entry
{
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try container.encode(tag, forKey: .tag)
        let colorValue = CustomColors.getColorValue(color: color).rawValue
        try container.encode(colorValue, forKey: .color)
    }

    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try values.decode(String.self, forKey: .title)
        body = try values.decode(String.self, forKey: .body)
        tag = try values.decode(String.self, forKey: .tag)
        let colorValue = try values.decode(Int.self, forKey: .color)
        color = CustomColors.getColor(color: CustomColors.colorValue(rawValue: colorValue)!)
    
    }
}
