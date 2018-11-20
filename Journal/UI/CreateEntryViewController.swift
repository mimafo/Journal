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
    let DefaultBodyText = "Enter body text here..."
    let defaultColor: UIColor = CustomColors.getColor(color: CustomColors.colorValue.red)
    
    //EditMode Enum
    enum EditMode {
        case add
        case update
    }
    
    //Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var addTag: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var colorViews: [ColorView]!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var fadeMessage: UILabel!
    @IBOutlet weak var fadeView: UIView!
    
    //Properties
    var entry: Entry?
    var mode: EditMode = EditMode.add
    var selectedColor: UIColor?
    
    //View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Delegates and Notifications
        bodyTextView.delegate = self
        registerForKeyboardNotifications()
        
        //Setup View
        colorViews.forEach { $0.delegate = self}
        mode = (entry == nil) ? .add : .update
        configEntry()
        
    }
    
    //Actions
    @IBAction func addTag(_ sender: UIButton) {
        presentAlertController()
    }
    
    @IBAction func deleteEntry(_ sender: UIBarButtonItem) {
        
        if mode == .add {
            entry = nil
            configEntry()
        } else {
            if let entry = entry {
                displayConfirmation("Delete", message: "Do you want to delete this entry?", accepted: { () -> Void in
                    EntryController.shared.deleteEntry(entry)
                    
                    self.fadeOutMessage("Entry Deleted!")
                    
                    self.entry = nil
                    self.configEntry()
                })
            }
        }
        
    }
    
    
    @IBAction func save(_ sender: UIButton) {
        guard let title = titleTextField.text, !title.isEmpty, let body = bodyTextView.text, !body.isEmpty, let color = selectedColor else { return }
        
        //Save the Entry info
        var tag: String? = nil
        if addTag.titleLabel?.text != AddTagText {
            tag = addTag.titleLabel?.text
        }
        
        if mode == .update {
            if let entry = entry {
                EntryController.shared.updateEntry(entry, with: title, body: body, tag: tag, color: color)
            }
        } else {
            EntryController.shared.CreateEntry(withTitle: title, body: body, tag: tag, color: color)
        }
        
        fadeOutMessage("Entry saved!")
        
        //Resign the responders
        resignResponders()
        
        //Reinitialize the elements on the screen
        entry = nil
        configEntry()
        
    }
    
    //Private helper functions
    private func resignResponders() {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
    }
    
    private func configEntry() {
        entry = entry ?? Entry(title: "", body: DefaultBodyText, tag: EntryController.untagged, color: defaultColor)
        
        if mode == .update {
            title = "Edit Entry"

        } else {
            title = "Add Entry"
            bodyTextView.text = DefaultBodyText
        }
        
        bindData(entry!)

    }
    
    private func bindData(_ entry: Entry) {
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
        selectColor(color: entry.color)
        if entry.tag == EntryController.untagged {
            addTag.setTitle(AddTagText, for: .normal)
        } else {
            addTag.setTitle(entry.tag, for: .normal)
        }
        
        //Select the color view
        let index = CustomColors.getColorValue(color: entry.color).rawValue
        colorViews[index - 1].toggle()
    }
}

extension CreateEntryViewController {
    func presentAlertController() {
        let alertController = UIAlertController(title: "Tag", message: AddTagText, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            if self.entry?.tag == EntryController.untagged {
                textField.placeholder = "Enter a tag you wish to add..."
            } else {
                textField.text = self.entry?.tag
            }
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
        self.selectedColor = color
        let colorValue = CustomColors.getColorValue(color: color)
        print("Color Int: \(colorValue)")
        //untoggle the previously selected color
        for view in colorViews {
            if view.tag != colorValue.rawValue && view.isSelected {
                view.toggle()
                print("Tag: \(view.tag)")
            }
        }
    }
    
}

extension CreateEntryViewController {
    func displayConfirmation(_ title: String, message: String, accepted: @escaping () -> Void) {
        let confirmation = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (_) in accepted() })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        confirmation.addAction(ok)
        confirmation.addAction(cancel)
        self.present(confirmation, animated: true, completion: nil)
        
    }
}

extension CreateEntryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == DefaultBodyText {
            textView.text = ""
        }
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = DefaultBodyText
        }
        textView.textColor = .lightGray
    }
    
}

extension CreateEntryViewController {
    func fadeOutMessage(_ message: String) {
        
        //Initialize fadeView and fadeMessage
        fadeMessage.text = message
        fadeView.isHidden = false
        fadeView.alpha = 1.0
        fadeView.layer.zPosition = 5.0
        
        //Animate the fade out message
        UIView.animate(withDuration: 2.0, delay: 0.5, animations: {
            //Fade out
            self.fadeView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { (_) in
            //Reset to hidden and default z-index
            self.fadeView.isHidden = true
            self.fadeView.layer.zPosition = 0.0
        }
    }
}
