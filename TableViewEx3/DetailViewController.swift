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

    @IBAction func saveButtonClicked(_ sender: Any) {
        if let plusText = plusTextField.text, let indexText = plusIndexField.text{
            if let rowNumber = Int(indexText) {
                if rowNumber <= DataStorage.itemArray.count, !plusText.isEmpty {
                    DataStorage.itemArray.insert(plusText, at: rowNumber)
                    self.dismiss(animated: true)
                } else {
                    warningMessage(message: "index가 범위를 벗어났거나 item 이름이 비어있습니다.")
                }
            } else {
                warningMessage(message: "index값이 잘못되었습니다.")
            }
  
        } else {
            warningMessage(message: "text가 존재하지 않습니다.")
        }
    }
}
