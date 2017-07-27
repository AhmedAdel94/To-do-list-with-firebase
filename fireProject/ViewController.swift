//
//  ViewController.swift
//  fireProject
//
//  Created by Ahmed Adel on 7/21/17.
//  Copyright © 2017 Ahmed Adel. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var myTextField: UITextField!
    
    @IBOutlet var myTableView: UITableView!
    
    var myRef : DatabaseReference?
    
    var handle:DatabaseHandle?
    
    var mylist:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myRef = Database.database().reference()
        
        handle = myRef?.child("list").observe(.childAdded, with: { (DataSnapshot) in
            if let item = DataSnapshot.value as? String{
                self.mylist.append(item)
                self.myTableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Saving data to database
    @IBAction func saveButton(_ sender: UIButton) {
        myRef = Database.database().reference()
        
        if myTextField.text != nil{
            myRef?.child("list").childByAutoId().setValue(myTextField.text)
            myTextField.text = ""
        }
    }
    
    
    // Setting up table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mylist.count
    }
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = mylist[indexPath.row]
        return cell
   
    }
    
    
    

}

