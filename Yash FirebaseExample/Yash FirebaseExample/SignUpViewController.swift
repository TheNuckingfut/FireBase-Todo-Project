//
//  SignUpViewController.swift
//  Yash FirebaseExample
//
//  Created by ashutosh deshpande on 07/12/2022.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextF: UITextField!
    
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func tapOFSignUpBtn(_ sender: UIButton) {
       
        if usernameTextF.text?.isEmpty ?? false && ((newPasswordTf.text?.isEmpty) != nil) && ((confirmPasswordTF.text?.isEmpty) != nil){
            print("Please Enter a Valid Email")
            return
        }
        if !isValidEmail(testStr : usernameTextF.text ?? "") {
            print("Enter a Valid Email")
            return
        }
        
        Auth.auth().createUser(withEmail: usernameTextF.text!, password: newPasswordTf.text!) { [unowned self](result, error) in
            if error == nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddTodoViewController") as! AddTodoViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }

    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
 }
