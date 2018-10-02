//
//  NetworkRequest.swift
//  BooksApp
//
//  Created by jeff on 10/2/18.
//  Copyright © 2018 automattic. All rights reserved.
//

import Foundation

struct NetworkRequest {
    func get(url: URL, callback: @escaping ([BookViewModel]?, Error?) -> Void ) {
        
        let dataTask = URLSession.shared.dataTask(with: url) {
            (data,response,error) in
                guard let data = data else {
//                callback(nil, error)
                    return
                }

                // This works:
                //let parsedData = try? JSONSerialization.jsonObject(with: data, options: [])
            
                // But JSONDecoder is more awesome :)
            
                do {
                    let googleBooksRoot = try JSONDecoder().decode(GoogleBooksRoot.self, from: data)
                    let books = self.createBooks(from: googleBooksRoot)
                    callback(books, nil)
                } catch {
                    callback(nil, error)
                }
        }
        dataTask.resume()
    }
    
    func createBooks(from googleBookRoot: GoogleBooksRoot) -> [BookViewModel] {
        return googleBookRoot.items.map {
            (googleBook) -> BookViewModel in
                return BookViewModel(
                    title: googleBook.volumeInfo.title,
                    subtitle: googleBook.volumeInfo.subtitle ?? "",
                    author: googleBook.volumeInfo.authors?.first ?? "",
                    extendedDescription: googleBook.volumeInfo.description ?? ""
                )
        }
    }
}
