//
//  ViewController.swift
//  iOS-Swift-EmailSender
//
//  Created by Pooya on 2020-10-17.
//  Copyright © 2020 centurytrail.com. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController , MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var reciverText: UITextField!
    @IBOutlet weak var ccText: UITextField!
    @IBOutlet weak var subjectText: UITextField!
    @IBOutlet weak var sendBtn:UIButton!
    
    @IBOutlet weak var bodyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reciverText.delegate = self
        ccText.delegate = self
        subjectText.delegate = self
        bodyText.delegate = self
        
    }

    
    @IBAction func sendAct(_ sender:Any){
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        
        if let recivertxt = reciverText.text{
            let recivers = recivertxt.components(separatedBy: ";")
            picker.setToRecipients(recivers)
        }
        
        if let ccTxt = ccText.text {
            let ccs = ccTxt.components(separatedBy: ";")
            picker.setCcRecipients(ccs)
        }
        
        if let subjecttxt = subjectText.text {
            picker.setSubject(subjecttxt)
        }
        
        picker.setMessageBody(bodyText.text, isHTML: true)
        
        //check if mail account exist
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail services are not available")
            return
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    
    
    // MFMailComposeViewControllerDelegate
    
    // Tells the delegate that the user wants to dismiss the mail composition view.
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    // UITextFieldDelegate
    
    // In the textFieldShouldReturn method we resign The FirstResponder so the control is given back to the ViewController.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // UITextViewDelegate
    
    // When the enter key is pressed. the keyboard will hide.
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        bodyText.text = textView.text
        
        if text == "\n" {
            textView.resignFirstResponder()
            
            return false
        }
        
        return true
    }
    
    
}

