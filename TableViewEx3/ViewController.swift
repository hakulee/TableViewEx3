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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SendDataDelgate {
    
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
    
    func sendData(text: String, index: Int) {
        DataStoragr.itemArray.append(text)
    }
    
    func isOnlyNumber(_ str: String) -> Bool {
        return str.filter({ $0.isNumber }).count == str.count
    }
    
    func warningMessage() {
        let alert = UIAlertController(title: "", message: "index값이 잘못되었습니다.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    @IBAction func addPlusButton(_ sender: Any) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else {return}
        detailVC.delegate = self
        present(detailVC, animated: true)
    }
    
    //index에 값이 있으면 index번째 아래에 텍스트 삽입
    @IBAction func addButtonClicked(_ sender: Any) {
        // index에 숫자 이외의 값이 들어왔을 때 warningMessage(alert) 띄우기
        if isOnlyNumber(indexNumber.text!) == false {
            warningMessage()
        } else { //index값에 숫자만 들어왔을 때
            if let rowNumber = Int(indexNumber.text!) {
                // rowNumber가 (DataStoragr.itemArray.count) 보다 작거같나 같고, text에 무언가 있을때만 추가
                if rowNumber <= DataStoragr.itemArray.count, itemTextField.text != "" {
                    DataStoragr.itemArray.insert(itemTextField.text!, at: rowNumber)
                } else {
                    // 그렇지 않을때는 warningMessage(alert)을 띄우기
                    warningMessage()
                }
            } else if itemTextField.text != "" { // index에 아무 값이 없을 때,
                // TextField 창이 빈칸일 때는 DataStoragr.itemArray에 추가 안함
                DataStoragr.itemArray.append(itemTextField.text!)
            }
            listTableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else {return}
        detailVC.delegate = self
        present(detailVC, animated: true)
    }
    
}
