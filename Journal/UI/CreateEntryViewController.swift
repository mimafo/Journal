//
//  CreateEntryViewController.swift
//  Journal
//
//  Created by Michael Folcher on 11/3/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import UIKit

class CreateEntryViewController: UIViewController {
    
    //Constants
    let AddTagText = "Add a Tag"
    
    //Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var addTag: UIButton!
    
    //Actions
    @IBAction func addTag(_ sender: UIButton) {
        presentAlertController()
    }
    
    @IBAction func save(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty, let body = bodyTextView.text, !body.isEmpty else { return }
        
        //Save the Entry info
        var tag: String? = nil
        if addTag.titleLabel?.text != AddTagText {
            tag = addTag.titleLabel?.text
        }
        
        EntryController.shared.CreateEntry(withTitle: title, body: body, tag: tag, color: .red)
        
        //Reinitialize the elements on the screen
        titleTextField.text = ""
        bodyTextView.text = ""
        addTag.setTitle(AddTagText, for: .normal)
        resignResponders()
    }
    
    //Private helper functions
    private func resignResponders() {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }
}

extension CreateEntryViewController {
    func presentAlertController() {
        let alertController = UIAlertController(title: "Tag", message: AddTagText, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter a tag you wish to add..."
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let textField = alertController.textFields?.first,
                let tag = textField.text,
                !tag.isEmpty else { return }
            self.addTag.setTitle(tag, for: .normal)
        }
        alertController.addAction(dismissAction)
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
        
    }
}
