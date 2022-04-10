//
//  AccountsListTableViewController.swift
//  PhotoApp
//
//  Created by  User on 10.04.2022.
//

import UIKit
import CoreData

class AccountsListTableViewController: UITableViewController {
    
    let reuseIdentifier = "reuseIdentifier"
    var exitButton: UIBarButtonItem!
    var model = [Account?]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        exitButton = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(logOut(parameters:)))
        navigationItem.rightBarButtonItem = exitButton
        
        let fetchRequest: NSFetchRequest<Account> = Account.fetchRequest()
                
        do {
            self.model = try context.fetch(fetchRequest)
        } catch {
            print("Cannot access to data base")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AccountTableViewCell

        // Configure the cell...
        cell.nicknameLabel.text = model[indexPath.row]?.nickname
        if let imageData = model[indexPath.row]?.image {
            cell.profilePhotoImageView.image = UIImage(data: imageData)
        } else {
            cell.profilePhotoImageView.image = UIImage(systemName: "photo")
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 10
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func logOut (parameters: UIBarButtonItem){
        UserDefaults.standard.set(false, forKey: "userIsLoggedIn")
        self.navigationController?.popToRootViewController(animated: true)
    }

}
