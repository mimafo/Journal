//
//  EntryStorageController.swift
//  Journal
//
//  Created by Michael Folcher on 11/17/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import Foundation

class EntryStorageController {
    
    private var directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let EntriesJsonName = "entries.json"
    
    func save(_ entries: [Entry]) {
        guard let url = directoryURL?.appendingPathComponent(EntriesJsonName, isDirectory: false) else { fatalError() }
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(entries)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
                
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchEntries() -> [Entry] {
        guard let url = directoryURL?.appendingPathComponent(EntriesJsonName, isDirectory: false) else { fatalError() }
        if !FileManager.default.fileExists(atPath: url.path) {
            return [] //Return an empty array of the file does not exist
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let entries = try decoder.decode([Entry].self, from: data)
                return entries
            } catch {
                return []
            }
        }
        fatalError("No data at \(url.path).")
    }
    
}
