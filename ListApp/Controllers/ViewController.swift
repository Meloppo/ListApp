//
//  ViewController.swift
//  ListingApp
//
//  Created by Melih Dogan on 31.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView:UITableView!
    
    var data = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @IBAction func onAddBarButtonClick(_ sender:UIBarButtonItem){
        let alertController = UIAlertController(title:"Add New Item",
                                                message:nil,
                                                preferredStyle: .alert)
        
        let defaultButton = UIAlertAction(title: "Add", style: .default) { _ in
            
            if  alertController.textFields?.first?.text != ""{
                self.data.append((alertController.textFields?.first?.text)!)
                self.tableView.reloadData()
            }
            else{
                let alertController = UIAlertController(title: "Warning!",
                                                        message: "You can not add empty item",
                                                        preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Okey", style: .cancel)
                alertController.addAction(okButton)
                self.present(alertController, animated: true)
            }
            
            
        }
        
        let cancelButton = UIAlertAction(title: "Abort", style: .cancel) { _ in
            self.tableView.reloadData()
        }
        
        alertController.addTextField()
        
        alertController.addAction(defaultButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    @IBAction func onRemoveBarButtonClick(_ sender:UIBarButtonItem){
        let alertController = UIAlertController(title: "Do you want to remove all items?", message: nil, preferredStyle: .alert
        )
        let defaultButton = UIAlertAction(title: "Yes!", style: .default) { _
            in
            self.data.removeAll()
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "No!", style: .cancel) { _ in
            
        }
        alertController.addAction(defaultButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true
        )
        
        
        
    }
    
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            self.data.remove(at: indexPath.row)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = .systemRed
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return config
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingDataOptions = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            let alertController = UIAlertController(title:"Add New Item",
                                                    message:nil,
                                                    preferredStyle: .alert)
            let text = alertController.textFields?.first?.text
            if text != "" {
                self.data[indexPath.row] = text!
            }
            else
            {
                let alertController = UIAlertController(title: "Warning!",
                                                        message: "You can not add empty item",
                                                        preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Okey", style: .cancel)
                alertController.addAction(okButton)
                self.present(alertController, animated: true)
            }
        }
        
        let config = UISwipeActionsConfiguration(actions: [editingDataOptions])
        return config
    }
}
