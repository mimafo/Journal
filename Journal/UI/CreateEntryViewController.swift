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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var colorViews: [ColorView]!
    
    
    //Properties
    var entry: Entry?
    var color: UIColor = CustomColors.getColor(color: CustomColors.colorValue.red)
    
    //View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotifications()
        if let entry = entry {
            print("\(entry)")
        } else {
            print("Entry is empty")
        }
        
        colorViews[0].toggle()
        colorViews.forEach { $0.delegate = self}
    }
    
    //Actions
    @IBAction func addTag(_ sender: UIButton) {
        presentAlertController()
    }
    
    @IBAction func exitPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
        
        //Resign the responders and pop this ViewController
        resignResponders()
        navigationController?.popViewController(animated: true)
        
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

extension CreateEntryViewController: KeyboardScrollable {
    func keyboardDidShow(_ notification: Notification) {
        keyboardWasShown(notification)
    }
    
    func keyboardWillHide(_ notification: Notification) {
        keyboardWillBeHidden(notification)
    }
    
    func getScrollView() -> UIScrollView? {
        return scrollView
    }
}

extension CreateEntryViewController: ColorViewDelegate {
    func selectColor(color: UIColor) {
        self.color = color
        //untoggle the previously selected color
        for view in colorViews {
            let colorValue = CustomColors.getColorValue(color: color)
            if view.tag != colorValue.rawValue && view.isSelected {
                view.toggle()
            }
        }
    }
    
}
