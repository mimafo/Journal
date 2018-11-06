//
//  EntryListViewController.swift
//  Journal
//
//  Created by Michael Folcher on 11/5/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import UIKit

class EntryListViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension EntryListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        let entry = EntryController.shared.getEntry(at: indexPath)
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.body
        return cell
    }
}
