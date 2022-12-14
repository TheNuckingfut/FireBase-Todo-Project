//
//  AddTodoViewController.swift
//  Yash FirebaseExample
//
//  Created by ashutosh deshpande on 07/12/2022.
//

import UIKit
import FirebaseDatabase


class AddTodoViewController: UIViewController {
    
    @IBOutlet weak var todoTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func onTouchOfBookmarkBtn(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TodosViewController") as! TodosViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onTapOfSaveBtn(_ sender: UIButton) {
       let id = Database.database().reference().child("todos").childByAutoId().key
        Database.database().reference().child("todos").child(id!).updateChildValues(["id": id!, "title": todoTF.text!])
        
    }
}
