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
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension EntryListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return EntryController.shared.tags.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return EntryController.shared.tags[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tag = EntryController.shared.tags[section]
        return EntryController.shared.getEntries(with: tag).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as? EntryCell else { return UITableViewCell() }
        let entry = EntryController.shared.getEntry(at: indexPath)
        cell.updateCell(with: entry)
        return cell
    }
}

extension EntryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension EntryListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEntrySegue" {
            guard let vc = segue.destination as? CreateEntryViewController,
                  let indexPath = tableView.indexPathForSelectedRow else { return }
            vc.entry = EntryController.shared.getEntry(at: indexPath)
        }
    }
}
