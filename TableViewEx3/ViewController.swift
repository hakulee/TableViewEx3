//
//  ViewController.swift
//  TableViewEx3
//
//  Created by hakulee on 2023/02/20.
//

import UIKit

struct DataStoragr {
    static var itemArray: [String] = []
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        DataStoragr.itemArray.append(itemTextField.text!)
        listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStoragr.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = DataStoragr.itemArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    //delete 방법
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataStoragr.itemArray.remove(at: indexPath.row)
            listTableView.reloadData()
        }
    }
}
