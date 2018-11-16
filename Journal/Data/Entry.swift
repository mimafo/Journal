//
//  Entry.swift
//  Journal
//
//  Created by Michael Folcher on 11/4/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import UIKit

struct Entry {
    var title: String
    var body: String
    var tag: String
    var color: UIColor
    
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
