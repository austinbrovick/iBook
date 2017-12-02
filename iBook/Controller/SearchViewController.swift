//
//  SearchViewController.swift
//  iBook
//
//  Created by Austin Brovick  on 12/2/17.
//  Copyright © 2017 Austin Brovick . All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var data: [String: Any]?
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("hello")
        let input = searchBar.text!
        getBook(input)
    }
    
    func getBook(_ title: String) {
        
        
        do {
            var content: NSData?
            if (title != "") {
                let stringWithNoSpaces = title.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                let urlString = "https://openlibrary.org/search.json?q=\(stringWithNoSpaces)"
                print(urlString)
                let url = URL(string: urlString)!
                content = NSData(contentsOf: url)
            }
            if (content == nil) {
                print("no content")
            } else {
                data = try JSONSerialization.jsonObject(with: content as! Data, options: []) as! [String:Any]
                print(data)
            }
        } catch {
            print(error)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
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
