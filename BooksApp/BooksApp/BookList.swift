//
//  BookList.swift
//  BooksApp
//
//  Created by jeff on 10/2/18.
//  Copyright © 2018 automattic. All rights reserved.
//

import UIKit

class BookList: UITableViewController {

    /*
    let books = [
        // These all call `BookViewModel.init`
        BookViewModel(title:"omgomg", subtitle: "fdsafds", author: "fdasdas", extendedDescription: "fadfads"),
        BookViewModel.init(title:"omgomg2", subtitle: "jiojoi", author: "ufdsf9ds", extendedDescription: "wfd bgdfsz klkfda lkjklfdsa  fdsafdsa"),
        .init(title:"omgomg3", subtitle: "o9of", author: "fdsagds", extendedDescription: " klkfda lkjklfdsa  fdsafdfds ds fds adssa"),
    ]*/
    
    var books: [BookViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        view.backgroundColor = .gray

        let networkRequest = NetworkRequest()
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=George"
        let url = URL(string: urlString)!

        networkRequest.get(url: url) { (books, error) in
            self.books = books ?? []

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)

        // Configure the cell...
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        print( selectedBook)
        performSegue(withIdentifier: "ToBookSegue", sender: selectedBook)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard
            let book = sender as? BookViewModel,
            let bookController = segue.destination as? BookViewController
        else {
            return
        }
        
        bookController.book = book

        print( book )
        print( bookController)
    }

}
