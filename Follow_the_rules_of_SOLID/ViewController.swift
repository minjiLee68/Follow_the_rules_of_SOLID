//
//  ViewController.swift
//  Follow_the_rules_of_SOLID
//
//  Created by 이민지 on 2022/05/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewmodel = PostGetViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem()
    }
    
    func navigationItem() {
        let editBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(submit(_:)))
        navigationItem.rightBarButtonItem = editBtn
    }
    
    @objc func submit(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "newPost") as? NewPostViewController else { return }
        dvc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.rowHeight = 80
        return viewmodel.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? tableViewCell else { return UITableViewCell() }
        
        viewmodel.postData { data in
            let title = data[indexPath.item].title
            let contents = data[indexPath.item].contents
            
            cell.update(title: title, contents: contents)
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailPost") else { return }
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class tableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var contents: UILabel!
    
    func update(title: String, contents: String) {
        self.title.text = title
        self.contents.text = contents
    }
}
