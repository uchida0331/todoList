//
//  ViewController.swift
//  todoList
//
//  Created by yuta uchida on 2020/01/02.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var todoTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doButton: UIButton!
    @IBOutlet weak var cell: UITableViewCell!
    
    var todoList:[String] = []
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.delegate = self
        tableView.dataSource = self
        todoTextField.delegate = self
        
        if UserDefaults.standard.object(forKey: "todoList") != nil {
            todoList = userDefaults.array(forKey: "todoList") as! [String]
        }
    }

    //テーブルの処理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = todoList[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height/8
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.bottom)
       
            userDefaults.removeObject(forKey: "todoList")
            userDefaults.set(todoList, forKey: "todoList")
            
            tableView.reloadData()
        }
    }
    
    
    //リターンを押した時
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if todoTextField.text != "" {
            
            todoList.append(todoTextField.text!)
            userDefaults.set(todoList, forKey: "todoList")
            
            todoTextField.resignFirstResponder()
            todoTextField.text = ""
            tableView.reloadData()
        } else {
            todoTextField.resignFirstResponder()
        }
        return true
    }
    
    //画面タップした時
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //DOボタン押した時
    @IBAction func doRegister(_ sender: Any) {
       
    }

    
    
    
}

