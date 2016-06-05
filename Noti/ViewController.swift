//
//  ViewController.swift
//  Noti
//
//  Created by Sebastián  Lara on 5/26/16.
//  Copyright © 2016 Sebastián  Lara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let todoList = TodoList()
    
    @IBAction func addButonPressed(sender: UIButton) {
        print("Agregando un elemento a la lsita: \(itemTextField.text)")
        todoList.addItem(itemTextField.text!)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = todoList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

