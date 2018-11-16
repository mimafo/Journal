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
        var set = Set<String>()
        entries.forEach {
            set.update(with: $0.tag.capitalized)
        }
        return set.sorted()
    }
    
    //Initializer
    init() {
        entries = [Entry(title: "First Entry", body: "Hello World, this is my first entry", tag: "Rock Star", color: .red),
                   Entry(title: "Second Entry", body: "This is another entry, blah, blah, blah", tag: "Mike Folcher", color: .blue),
                   Entry(title: "Another Entry", body: "Testing, testing: one, two, three", tag: "Rock Star", color: .green),
                   Entry(title: "My Stuff", body: "Hello again, how are you doing today?", tag: "Special Info", color: .green),
                   Entry(title: "More Stuff", body: "This is getting really boring.  Hello out there!", tag: "Tag Me", color: .orange),
                   Entry(title: "Testing", body: "Hello World, is there anybody in there?  Just nod if you can hear me.  Is there any one at home?  Relax, I need some information first.  Just some basic facts, can you show me where it hurt?", tag: "You are it", color: .yellow),
                   Entry(title: "Another Test", body: "Getting closer to being done.  Almost there...", tag: "Tag Me", color: .red),
                   Entry(title: "Some More Data", body: "Testing again, I am here!.!.!.!:)", tag: "Testing", color: .blue),
                   Entry(title: "Almost Done", body: "Welcome to the thunderdome~!", tag: "Hello", color: .green),
                   Entry(title: "Last One", body: "Goodbye World, this is my last entry", tag: "Rock Star", color: .red)
        ]
        
    }
    
    // CRUD operations
    func CreateEntry(withTitle title: String, body: String, tag: String? = nil, color: UIColor) {
        let entry = Entry(title: title, body: body, tag: tag ?? untagged, color: color)
        entries.append(entry)
        //Save to disk
    }
    
    func getEntry(at indexPath: IndexPath) -> Entry {
        let tag = tags[indexPath.section]
        let entries = getEntries(with: tag)
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
        print("Index: \(index)")
        entries.remove(at: index)
        //Save to disk
    }
    
     func getEntries(with tag: String) -> [Entry] {
        return entries.filter { $0.tag.lowercased() == tag.lowercased() }
    }
}
