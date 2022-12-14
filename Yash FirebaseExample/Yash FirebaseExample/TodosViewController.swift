//
//  TodosViewController.swift
//  Yash FirebaseExample
//
//  Created by ashutosh deshpande on 07/12/2022.
//

import UIKit
import FirebaseDatabase

class TodosViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    var todoArray : [[String : String]] = [[:]]
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDataFromFirebase()
        
    }
    func fetchDataFromFirebase() {
        let ref = Database.database().reference().child("todos")
        ref .observe(.value) { [unowned self](snapshot) in
            if snapshot.exists() {
                self.todoArray = [[:]]
                for child in snapshot.children {
                    let value = (child as! DataSnapshot).value as! [String : String]
                    self.todoArray.append(value)
                }
                
                todoTableView.reloadData()
        }
        
    }
}
}

extension TodosViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = todoArray[indexPath.row]["title"]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = todoArray[indexPath.row]
        let ac = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [unowned self](act) in
            self.editValueFromDatabase(indexpath: indexPath)
        }))
        
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (act) in
            Database.database().reference().child("todos").child(obj["id"]!).removeValue()
        }))
        
        ac.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
    func editValueFromDatabase(indexpath: IndexPath) {
        
        var obj = todoArray[indexpath.row]
        let ac = UIAlertController(title: "Edit", message: "Do You Want To Edit", preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "Update", style: .default, handler: { (act) in
            obj["title"] = ac.textFields![0].text
            Database.database().reference().child("todos").child(obj["id"]!).updateChildValues(obj)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        
        present(ac, animated: true, completion: nil)
    }
}
