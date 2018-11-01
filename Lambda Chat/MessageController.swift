//
//  MessageController.swift
//  Lambda Chat
//
//  Created by Iyin Raphael on 10/31/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation
import Firebase

class MessageController {
    
    func fetchMessages() {
        
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            let message = Message(sender: sender, messageBody: text)
            self.messages.append(message)
        }
    }
    
    var messages: [Message] = [Message]()
}
