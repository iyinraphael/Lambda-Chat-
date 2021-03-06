//
//  ViewController.swift
//  Flash Chat
//
//  Created by Iyin Raphael on 10/30/2018.

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    // Declare instance variables here

    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextfield.delegate = self
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        fetchMessages()
        
    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as? CustomMessageCell else { return UITableViewCell()}
        let message = messages[indexPath.row]
        cell.messageBody.text = message.messageBody
        cell.senderUsername.text = message.sender
        cell.avatarImageView.image = UIImage(named: "egg")
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody": messageTextfield.text!]
        
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error, refrence) in
            
            if let error = error {
                NSLog("\(error)")
            }else{
              
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text! = ""
            }
        }
        
        
    }
    
    func fetchMessages() {
        
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message(sender: sender, messageBody: text)
            self.messages.append(message)
            
            self.configureTableView()
            self.messageTableView.reloadData()
        }
    }
    
    var messages: [Message] = [Message]()
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        do{
           try Auth.auth().signOut()
             navigationController?.popToRootViewController(animated: true)
        }catch {
            NSLog("Error, there was a problrm signing out")
        }
    }

}
