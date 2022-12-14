//
//  ViewController.swift
//  Yash FirebaseExample
//
//  Created by ashutosh deshpande on 07/12/2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { [unowned self](auth, user) in
            let addTodovc = storyboard?.instantiateViewController(withIdentifier: "AddTodoViewController")as! AddTodoViewController
            navigationController?.pushViewController(addTodovc, animated: true)
        }
          }

    @IBAction func onTapOFSignInBtn(_ sender: UIButton) {
        if usernameTF.text?.isEmpty ?? false && ((passwordTF.text?.isEmpty) != nil){
            print("Please Enter a Valid Email")
            return
        }
        if !isValidEmail(testStr : usernameTF.text ?? "") {
            print("Enter a Valid Email")
            return
        }
        Auth.auth().signIn(withEmail: usernameTF.text!, password: passwordTF.text!) { [unowned self](result, error) in
            if error == nil {
                print("Login Successful")
                print(result?.user as Any)
                DispatchQueue.main.async {
                    let addTodovc = self.storyboard?.instantiateViewController(withIdentifier: "AddTodoViewController")as! AddTodoViewController
                    self.navigationController?.pushViewController(addTodovc, animated: true)
                }
            }else {
                print(error?.localizedDescription as Any)
            }
        }
        
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func onTapOFSignUpBtn(_ sender: Any) {
      let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")as! SignUpViewController
        navigationController?.pushViewController(signupVC, animated: true)
    }
}

