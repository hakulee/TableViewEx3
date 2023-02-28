//
//  DetailViewController.swift
//  TableViewEx3
//
//  Created by hakulee on 2023/02/27.
//

import UIKit

protocol SendDataDelgate {
    func sendData(text: String, index: Int)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var plusTextField: UITextField!
    @IBOutlet weak var plusIndexField: UITextField!
    
    var delegate: SendDataDelgate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    @IBAction func saveButtonClicked(_ sender: Any) {
        // index값에 숫자 이외의 값이 들어왔을 때 warningMessage(alert) 띄우기
        if isOnlyNumber(plusIndexField.text!) == false {
            warningMessage()
        } else {
            // index값에 숫자만 들어왔을 때
            if let rowNumber = Int(plusIndexField.text!) {
                // rowNumber가 (DataStoragr.itemArray.count) 보다 작거같나 같고, text에 무언가 있을때만 추가
                if rowNumber <= DataStoragr.itemArray.count, plusTextField.text != "" {
                    DataStoragr.itemArray.insert(plusTextField.text!, at: rowNumber)
                    self.dismiss(animated: true)
                } else {
                    // 그렇지 않을때는 warningMessage(alert)을 띄우기
                    warningMessage()
                }
            } else if plusTextField.text != "" {
                // index에 아무 값이 없을 때,
                // TextField 창이 빈칸일 때는 DataStoragr.itemArray에 추가 안함
                delegate?.sendData(text: plusTextField.text!, index: Int(plusIndexField.text!) ?? DataStoragr.itemArray.count)
                self.dismiss(animated: true)
            }
        }
    }
}
