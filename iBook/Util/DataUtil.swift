//
//  File.swift
//  iBook
//
//  Created by iGuest on 12/2/17.
//  Copyright © 2017 Austin Brovick . All rights reserved.
//

import Foundation

class DataUtil {
    // Local files
    let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let file_user_history = ""
    let file_user_challenge = ""
    let file_categories = ""
    let file_subCategories = ""
    
    // Openlibrary endpoints
    let api_openlib = "http://openlibrary.org/search.json?"
    let api_openlib_author = "author=%@&"
    let api_openlib_general = "q=%@`"
    let api_openlib_title = "title=%@&"
    let api_openlib_page = "page=%d&"
    
    //Gutenberghttp endpoints
    let api_gut = "https://gutenbergapi.org/texts/%d"
    
    func getBookGutenberg(bookNum: String) -> [String:Any] {
        let urlString = String(format: api_gut, bookNum)
        return jsonQuery(urlString)
    }
    
    func searchBook(query: String) -> [String:Any] {
        let cleanQuery = query.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let urlString = String(format: api_openlib + api_openlib_general, cleanQuery)
        return jsonQuery(urlString)
    }
    
    fileprivate func jsonQuery(urlString: String) -> [String:Any] {
        do {
            NSLog("Making json query to " + urlString)
            let url = URL(string: urlString)!
            var content: NSData? = NSData(contentsOf: url)
            if (content == nil) {
                print("no content")
            } else {
                data = try JSONSerialization.jsonObject(with: content as! Data, options: []) as! [String:Any]
                print(data)
                return data
            }
        } catch {
            print(error)
            return ["error":String(error)]
        }
    }
    
    fileprivate func fileQuery(urlString: String) -> Data {
        do {
            NSLog("Making file query to " + urlString)
            let url = URL(string: urlString)!
            var content: NSData? = NSData(contentsOf: url)
            if (content == nil) {
                print("no content")
            }
            return data
        } catch {
            print(error)
            return nil
        }
    }
    
    func saveData(file to: String, data: String) {
        saveData(file: to, data.data(using: .utf8))
    }
    
    func saveData(file to: String, data: Data) {
        if dir != nil {
            let fileurl = dir?.appendingPathComponent(to)
            do {
                try data.write(to: fileurl!, options: Data.WritingOptions.atomic)
            }
            catch { NSLog(error.localizedDescription) }
        }
        else {
            NSLog("DataUtil document dir is nil while saving data to " + to)
            NSLog(dir)
        }
    }
    
    func loadData(file from: String){
        if dir != nil {
            let fileurl = dir?.appendingPathComponent(from)
            var data: Data? = nil
            do {
                try data = Data(contentsOf: fileurl!)
            }
            catch { NSLog(error.localizedDescription) }
            if data != nil && data!.count > 0 {
                QuizDataSource.quizzes = self.parseJSON(data!)
                DispatchQueue.main.async {
                    if self.tableView != nil {
                        self.vc!.data = QuizDataSource.quizzes
                        self.tableView?.reloadData()
                    }
                }
            }
        }
        else {
            NSLog("DataUtil document dir is nil while reading data from " + from)
            NSLog(dir)
        }
    }
    
    func parseJSON(_ input: String) {
        return try! JSON(data: inputData)
    }
}
