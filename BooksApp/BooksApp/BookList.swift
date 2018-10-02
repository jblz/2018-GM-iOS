import UIKit

class BookList: UITableViewController {

    let books = [
        BookViewModel(title: "Title 1", subtitle: "Sub 1", author: "author 1", extendedDescription: "extended 1"),
        BookViewModel(title: "Title 2", subtitle: "Sub 2", author: "author 2", extendedDescription: "extended 2"),
        BookViewModel(title: "Title 3", subtitle: "Sub 2", author: "author 2", extendedDescription: "extended 2")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // 0.- Deqeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)

        // 1.- Grab a model object
        let book = books[indexPath.row]

        // 2.- Populate the cell's title
        cell.textLabel?.text = book.title

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //0.- Fetch a model object
        let selectedBook = books[indexPath.row]

        print(selectedBook.title)
    }
}
