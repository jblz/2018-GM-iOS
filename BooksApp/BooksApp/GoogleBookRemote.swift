//
//  GoogleBookRemote.swift
//  BooksApp
//
//  Created by jeff on 10/2/18.
//  Copyright © 2018 automattic. All rights reserved.
//

import Foundation

struct GoogleBooksRoot: Decodable {
    let items: [GoogleBook]
}

struct GoogleBook: Decodable {
    let id: String
    let volumeInfo: GoogleBookInfo
}

struct GoogleBookInfo: Decodable {
    let title: String
    let subtitle: String?
    let authors: [String]?
    let description: String?
    let imageLinks: GoogleBookImageLinks?
}

struct GoogleBookImageLinks: Decodable {
    let smallThumbnail: String
    let thumbnail: String
}
