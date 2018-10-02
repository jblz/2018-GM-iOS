//
//  BookViewController.swift
//  BooksApp
//
//  Created by Cesar Tardaguila on 1/10/2018.
//  Copyright © 2018 automattic. All rights reserved.
//

import UIKit

struct BookViewModel {
    let title: String
    let subtitle: String
    let author: String
    let extendedDescription: String
    
/*
    This is implied:
    init(title: String, subtitle: String, author: String, extendedDescription: String) {
        self.title = title
        self.subtitle = subtitle
        self.author = author
        self.extendedDescription = extendedDescription
    }
 */
}

final class BookViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!

    let book = BookViewModel(
        title: "Moby Dick",
        subtitle: "A book about a whale",
        author: "Melville",
        extendedDescription: "This is a book about a manf sfsaklfjds akl f;djskl fjdsakl fjdskl fslkf jdskl fjdsklfj dsjldf jkl jkl dskjlfdsjklfdsjklfd asjklfdasjkldfsajfkldsjkldfs ja jkladjklfdsajklfads")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        assignAuthor()
        assignDesc()
        assignImage()
        assignSubtitle()
        assignTitle()

        // This is shorthand for:
        // view.backgroundColor = UIColor.red
        // coerced from the view.backgroundColor optional
    }
    
    private func assignSubtitle() {
        subtitleLabel.text = book.subtitle
    }
    
    private func assignTitle() {
        titleLabel.text = book.title
        titleLabel.textColor = .green
    }
    
    private func assignAuthor() {
        authorLabel.text = book.author
    }

    private func assignDesc() {
        descriptionTextView.text = book.extendedDescription
    }
    
    private func assignImage() {
        coverImageView.backgroundColor = .gray
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
