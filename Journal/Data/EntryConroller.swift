//
//  EntryConroller.swift
//  Journal
//
//  Created by Michael Folcher on 11/4/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import UIKit

class EntryController {
    
    static let shared = EntryController()
    let untagged = "Untagged"
    
    var entries: [Entry] = []
    var tags: [String] {
        return []
    }
    
    // CRUD operations
    func CreateEntry(withTitle title: String, body: String, tag: String? = nil, color: UIColor) {
        let entry = Entry(title: title, body: body, tag: tag ?? untagged, color: color)
        entries.append(entry)
        //Save to disk
    }
    
    func getEntry(at indexPath: IndexPath) -> Entry {
        //let tag = tags[indexPath.section]
        //let entries = getEntries(with: tag)
        return entries[indexPath.row]
    }
    

    
    func updateEntry(_ entry: Entry, with title: String, body: String, tag: String? = nil, color: UIColor) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries[index].title = title
        entries[index].body = body
        entries[index].tag = tag ?? untagged
        entries[index].color = color
        //Save to disk
    }
    
    func deleteEntry(_ entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
        //Save to disk
    }
    
    // Internal helpers
    private func getEntries(with tag: String) -> [Entry] {
        return entries.filter { $0.tag == tag }
    }
}
