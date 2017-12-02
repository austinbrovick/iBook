//
//  BookDetailViewController.swift
//  iBook
//
//  Created by Austin Brovick  on 12/2/17.
//  Copyright © 2017 Austin Brovick . All rights reserved.
//

import UIKit


class BookDetailViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var authors: UILabel!
    @IBOutlet weak var subjects: UILabel!
    @IBOutlet weak var publishYear: UILabel!
    @IBOutlet weak var pageCount: UILabel!
    @IBOutlet weak var language: UILabel!
    
    @IBOutlet weak var publisher: UILabel!
    @IBOutlet weak var publishLocation: UILabel!
    @IBOutlet weak var identifier: UILabel!
    
    @IBOutlet weak var coverPhoto: UIImageView!
    
    @IBOutlet weak var preview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preview.isEditable = false
        
        let isbn = "9780980200447"
        let urlString = URL(string: "https://openlibrary.org/api/books?bibkeys=ISBN:" + isbn + "&jscmd=details&format=json")
        
        
        
        
        let task = URLSession.shared.dataTask(with: urlString!) {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let usableData = data {
                    let string = String(data: usableData, encoding: String.Encoding.utf8)
                    print (string!) // JSON Serialization
                    
                    let json = try? JSONSerialization.jsonObject(with: usableData, options: []) as! [String:Any]
                    
                    
                    if let dictionary = json {
                        let book = dictionary["ISBN:" + isbn]! as! [String: Any]
                        _ = book["bib_key"] as! String
                        let details = book["details"] as! [String:Any]
                        
                        let authorList = details["authors"] as! [[String:Any]]
                        let author = authorList[0]["name"] as! String
                        
                        print(author)
                    }
                }
            }
        }
        
        task.resume()
        
        
        
        bookTitle.text = "Moby Dick"
        authors.text = ""
        subjects.text = ""
        publishYear.text = ""
        pageCount.text = ""
        language.text = ""
        
        publisher.text = ""
        publishLocation.text = ""
        identifier.text = ""
        preview.text = "No Preview Text"
        
        // set cover image
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
