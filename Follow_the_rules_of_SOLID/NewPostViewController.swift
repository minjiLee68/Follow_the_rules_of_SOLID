//
//  NewPostViewController.swift
//  Follow_the_rules_of_SOLID
//
//  Created by 이민지 on 2022/05/12.
//

import UIKit

class NewPostViewController: UIViewController {
    @IBOutlet weak var titleEdit: UITextField!
    @IBOutlet weak var contentsEdit: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem()
    }
    
    func navigationItem() {
        let saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(submit(_:)))
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    @objc func submit(_ sender: Any) {
        saveBtn()
    }
    
    func saveBtn() {
        guard let title = self.titleEdit.text else { return }
        guard let contents = self.contentsEdit.text else { return }
        
        let postviewmodel = PostSetViewModel()
        postviewmodel.setPostData(title: title, contents: contents)
        
        self.navigationController?.popViewController(animated: true)
    }
}
