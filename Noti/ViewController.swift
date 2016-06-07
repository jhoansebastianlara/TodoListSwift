//
//  ViewController.swift
//  Noti
//
//  Created by Sebastián  Lara on 5/26/16.
//  Copyright © 2016 Sebastián  Lara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let todoList = TodoList()
    static let MAX_TEXT_SIZE = 10
    // class let MAX_TEXT_SIZE = 10 // las variables de clase se pueden sobreescribir en las subclases, con static no se puede
    var selectedItem: String?
    
    @IBAction func addButonPressed(sender: UIButton) {
        print("Agregando un elemento a la lsita: \(itemTextField.text)")
        todoList.addItem(itemTextField.text!)
        tableView.reloadData()
        self.itemTextField.text = nil
        self.itemTextField?.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = todoList
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: evento q se llama cada vez q se scrollea la tabla (metodos del table view delegate)
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.itemTextField?.resignFirstResponder()
    }
    
    // se selecciono una fila en este indice
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Se ha didSelectRowAtIndexPathº la fila \(indexPath.row)")
        self.selectedItem = self.todoList.getItem(indexPath.row)
        self.performSegueWithIdentifier("showItemSegue", sender: self) // navegacion con segue
        // navegacion manual
//        let detailVC = DetailViewController()
//        detailVC.item = self.selectedItem
//        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        print("Se ha didHighlightRowAtIndexPath la fila \(indexPath.row)")
    }
    
    // pasar params al otro viewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailViewController = segue.destinationViewController as?
            DetailViewController {
            print("seleccionar item \(self.selectedItem)")
            detailViewController.item = self.selectedItem
        }
    }
    
    // MARK: Metodos del text field delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // este metodo es invocado cuando el usuario esta escribiendo
        if let tareaString = textField.text as? NSString {
            let updateString = tareaString.stringByReplacingCharactersInRange(range, withString: string)
            
            return updateString.characters.count <= ViewController.MAX_TEXT_SIZE
        } else {
            // el usuario no ha escrito nada
            return true
        }
    }

}

