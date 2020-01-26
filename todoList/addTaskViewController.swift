//
//  addTaskViewController.swift
//  todoList
//
//  Created by yuta uchida on 2020/01/23.
//  Copyright © 2020 yuta. All rights reserved.
//

import UIKit

class addTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var todoTextField: UITextField!
    var todoList:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTextField.delegate = self
        view.backgroundColor = .blue
    }
    
    //リターンを押した時
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          if todoTextField.text != "" {
              
              todoList.append(todoTextField.text!)
              UserDefaults.standard.set(todoList, forKey: "todoList")
              
              todoTextField.resignFirstResponder()
              todoTextField.text = ""
             
              dismiss(animated: true, completion: nil)

          } else {
              todoTextField.resignFirstResponder()
          }
          return true
      }
      
      //入力状態で画面をタップした時
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          view.endEditing(true)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
