//
//  ViewController.swift
//  todoList
//
//  Created by yuta uchida on 2020/01/02.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cell: UITableViewCell!
    
    let userDefaults = UserDefaults.standard
    var todoList:[String] = []
    var textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.delegate = self
        tableView.dataSource = self

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
        return tableView.frame.size.height/10
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    //右スワイプで削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == UITableViewCell.EditingStyle.delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.bottom)
       
            userDefaults.removeObject(forKey: "todoList")
            userDefaults.set(todoList, forKey: "todoList")
        }
    }
    
    //+ボタン押した時
    @IBAction func addTaskButton(_ sender: Any) {
        
        let alert = UIAlertController.init(title: "新しいTaskを追加", message:"" , preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "追加", style: .default) { (action) in
            
            let newTask:String = self.textField.text!
            
            if newTask != "" {
                self.todoList.append(newTask)
                self.userDefaults.set(self.todoList, forKey: "todoList")
                self.tableView.reloadData()
            }
        }
        let cancel = UIAlertAction.init(title: "キャンセル", style: .cancel)
        
        alert.addTextField { (alertTextField) in
            self.textField = alertTextField
        }
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

