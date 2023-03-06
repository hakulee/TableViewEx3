//
//  ViewController.swift
//  TableViewEx3
//
//  Created by hakulee on 2023/02/20.
//

import UIKit

struct DataStorage {
    static var itemArray: [String] = []
    
}

extension UIViewController {
    func warningMessage(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
}

class ViewController: UIViewController{
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var indexNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listTableView.reloadData()
    }
    
    @IBAction func addPlusButton(_ sender: Any) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else {return}
        detailVC.delegate = self
        present(detailVC, animated: true)
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        if let itemText = itemTextField.text, let rowText = indexNumber.text {
            if let rowNumber = Int(rowText) {
                if rowNumber <= DataStorage.itemArray.count, !itemText.isEmpty {
                    DataStorage.itemArray.insert(itemText, at: rowNumber)
                    listTableView.reloadData()
                } else {
                    warningMessage(message: "index값이 벗어났거나 item 이름이 비어있습니다.")
                }
            } else {
                if rowText.isEmpty {
                    DataStorage.itemArray.append(itemText)
                    listTableView.reloadData()
                } else {
                    warningMessage(message: "index값이 잘못되었습니다.")
                }
            }
        } else {
            warningMessage(message: "텍스트가 존재하지 않습니다.")
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else {return}
        detailVC.delegate = self
        present(detailVC, animated: true)
    }
}

extension ViewController: UITableViewDelegate { }

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = DataStorage.itemArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    //delete 방법
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataStorage.itemArray.remove(at: indexPath.row)
            listTableView.reloadData()
        }
    }
}

extension ViewController: SendDataDelgate {
    func sendData(text: String, index: Int) {
        DataStorage.itemArray.append(text)
    }
}
