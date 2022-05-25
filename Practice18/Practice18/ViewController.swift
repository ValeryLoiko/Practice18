//
//  ViewController.swift
//  Practice18
//
//  Created by Diana on 23/05/2022.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDoneButtonAppearence()
        addKeybordListener()
        addTextFieldListener()
    }
    
    
    @IBAction func actionDoneButton(_ sender: UIButton) {
        userNameLabel.text = "Privet"
    }
    
    @IBAction func ActionDesignButton(_ sender: UIButton) {
    }
    
    private func configureDoneButtonAppearence() {
        doneButton.setBackgroundImage(UIImage(named: "buttonNormal"), for: .normal)
        doneButton.setBackgroundImage(UIImage(named: "buttonHighlighted") , for: .highlighted)
        doneButton.setTitle("Continue", for: .normal)
        doneButton.setTitle("Stop", for: .highlighted)
        doneButton.setTitleColor(.blue, for: .normal)
        doneButton.setTitleColor(.red, for: .highlighted)
    }
    
    private func addKeybordListener() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(keybordWillShow(notification:)),
                         name: UIResponder.keyboardWillShowNotification,
                         object: nil)
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(keybordWillHide(notification:)),
                         name: UIResponder.keyboardWillHideNotification,
                         object: nil)
    }
    
    @objc
    private func keybordWillShow(notification: Notification ) {
        guard let keybordFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        scrollView.contentInset.bottom = keybordFrame.height + 50
        scrollView.verticalScrollIndicatorInsets.bottom = keybordFrame.height
        scrollView.scrollRectToVisible(doneButton.frame, animated: true)
        scrollView.keyboardDismissMode = .onDrag
    }
    
    private func addTextFieldListener() {
        func addObserver(source textField: UITextField, target label: UILabel) {
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField,
                queue: OperationQueue.main) { _ in
                    label.text = textField.text
                }
        }
        addObserver(source: userNameField, target: userNameLabel)
        addObserver(source: passwordField, target: passwordLabel)
        addObserver(source: phoneNumberField, target: phoneNumberLabel)
    }
    
    @objc
    private func keybordWillHide(notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}
