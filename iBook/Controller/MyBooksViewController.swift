//
//  MyBooksViewController.swift
//  iBook
//
//  Created by Austin Brovick  on 12/2/17.
//  Copyright © 2017 Austin Brovick . All rights reserved.
//

import Foundation
import UIKit

class MyBooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myBooks: [[Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: load my books
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return myBooks.count
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let title = "title"
        cell.textLabel!.text = title
        cell.detailTextLabel?.text = "description"
        cell.imageView?.image = UIImage(named: "default")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let book = myBooks![indexPath.row] as [Any]
        performSegue(withIdentifier: "bookDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "bookDetail") {
            let bookDetailVC = segue.destination as! BookDetailViewController
/*
             TODO: bookDetailVC params
             
             bookDetailVC.book = book object
             
            bookDetailVC.title = "title"
            bookDetailVC.author = "author"
            bookDetailVC.date = "date"
            bookDetailVC.cover = "cover"
            bookDetailVC.language = "language"
             bookDetailVC.summary = "summary"
*/
        }
    }
}
