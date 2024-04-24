//
//  ViewController.swift
//  ToDoList
//
//  Created by Work on 24/04/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
        
        private let table: UITableView = {
            let table = UITableView()
            table.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
            return table
        }()
    
    var items = [String]()
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.items = UserDefaults.standard.stringArray(forKey: "items") ?? []
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New Item",
                                      message: "Enter new item",
                                      preferredStyle: .alert)
        
        alert.addTextField{ filed in
            filed.placeholder = "Enter Item"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        
        alert.addAction(UIAlertAction(title: "Done",
                                      style: .default,
                                      handler: { [weak self](_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty{
                    DispatchQueue.main.async {
                        let newEntry = [text]
                        UserDefaults.standard.setValue(newEntry, forKey: "items")
                        self?.items.append(text)
                        self?.table.reloadData()
                    }
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

}
