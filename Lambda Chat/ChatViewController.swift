//
//  ViewController.swift
//  Flash Chat
//
//  Created by Iyin Raphael on 10/30/2018.

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    // Declare instance variables here

    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTextfield.delegate = self
        
        
        //TODO: Set the tapGesture here:
        
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()

        
    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as? CustomMessageCell else { return UITableViewCell()}
    
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    //TODO: Declare tableViewTapped here:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        
        //TODO: Send the message to Firebase and save it in our database
        
        
    }
    
    //TODO: Create the retrieveMessages method here:
    
    

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        do{
           try Auth.auth().signOut()
             navigationController?.popToRootViewController(animated: true)
        }catch {
            NSLog("Error, there was a problrm signing out")
        }
    }
    


}
