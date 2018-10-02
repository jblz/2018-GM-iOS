//
//  BookViewController.swift
//  BooksApp
//
//  Created by Cesar Tardaguila on 1/10/2018.
//  Copyright © 2018 automattic. All rights reserved.
//

import UIKit

struct BookViewModel: CustomStringConvertible {
    let title: String
    let subtitle: String
    let author: String
    let extendedDescription: String

    var description: String {
        return "I am a book, my title is \(title)"
    }
}

final class BookViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!

    let book = BookViewModel(title: "Moby Dick", subtitle: "A book about a whale", author: "Herman Melville", extendedDescription: "This is a book about a man tryin gto hunt a whale.")

    override func viewDidLoad() {
        super.viewDidLoad()

        assignTitle()
        assignSubtitle()
        assignAuthor()
        assignDescription()

        print(book)
    }

    private func assignTitle() {
        titleLabel.text = book.title
    }

    private func assignSubtitle() {
        subtitleLabel.text = book.subtitle
    }

    private func assignAuthor() {
        authorLabel.text = book.author
    }

    private func assignDescription() {
        descriptionTextView.text = book.extendedDescription
    }
}
