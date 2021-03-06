//
//  RegisterViewController.swift
//  Lambda Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if let error = error {
                NSLog("Error occured trying to sign in: \(error)")
        }else { 
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
        
        

        
        
    } 
    
    
}
