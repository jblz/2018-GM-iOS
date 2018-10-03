import UIKit

class BookList: UITableViewController, UISearchResultsUpdating {
    private lazy var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()

    var books = [
        BookViewModel(title: "Title 1", subtitle: "Sub 1", author: "author 1", extendedDescription: "extended 1", thumbnail: ""),
        BookViewModel(title: "Title 2", subtitle: "Sub 2", author: "author 2", extendedDescription: "extended 2", thumbnail: ""),
        BookViewModel(title: "Title 3", subtitle: "Sub 2", author: "author 2", extendedDescription: "extended 2", thumbnail: "")
    ]

    private lazy var networkRequest = NetworkRequest()
    private lazy var scheduler = Scheduler.init(seconds: 2)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        insertSearchController()
    }
    
    private func search(term: String) {
        guard let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed ) else {
            return
        }
        print("searching \(encodedTerm)")
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(encodedTerm)"
        let url = URL(string: urlString)!
        
        networkRequest.get(url: url) { (books, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.showError(error)
                }
                return
            }

            self.books = books ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func showError(_ error: Error) {
        let description = error.localizedDescription;

        let alertController = UIAlertController(title: "Error", message: description, preferredStyle: .alert)

        let dismissAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    private func insertSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search books..."
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let book = sender as? BookViewModel,
            let bookController = segue.destination as? BookViewController else {
            return
        }

        bookController.book = book
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

        performSegue(withIdentifier: "ToBookSegue", sender: selectedBook)
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText.count > 0 {
            scheduler.debounce { [weak self] in
                self?.search(term: searchText)
            }
        }
    }
}
