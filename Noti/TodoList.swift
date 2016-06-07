//
//  TodoList.swift
//  Noti
//
//  Created by Sebastián  Lara on 6/5/16.
//  Copyright © 2016 Sebastián  Lara. All rights reserved.
//

import UIKit

class TodoList: NSObject {
    var items: [String] = []
    
    override init() {
        super.init()
        loadItems()
    }
    
    private let fileURL: NSURL = {
        let fileManager = NSFileManager.defaultManager()
        let documentDirectoryURLs = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as [NSURL]
        let documentDirectoryURL = documentDirectoryURLs.first!
        print("path de documents \(documentDirectoryURL)")
        return documentDirectoryURL.URLByAppendingPathComponent("todolist.items")
    }()
    
    func addItem(item: String) {
        items.append(item)
        saveItems()
    }
    
    func saveItems() {
        let itemsArray = items as NSArray
        
        if itemsArray.writeToURL(self.fileURL, atomically: true) {
            print("Guardado")
        } else {
            print("Error guardando")
        }
    }
    
    func loadItems() {
        if let itemsArray = NSArray(contentsOfURL: self.fileURL) as? [String] {
            self.items = itemsArray
        }
    }
    
    func getItem(index: Int) -> String {
        return items[index]
    }
}

extension TodoList: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let item = items[indexPath.row]
        cell.textLabel!.text = item
        
        return cell
    }
    
    // para saber si la celda se puede borrar o editar
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // si puede editar cualquier celda
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        items.removeAtIndex(indexPath.row)
        saveItems()
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        
        tableView.endUpdates()
    }
}
