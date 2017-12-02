//
//  SettingsViewController.swift
//  iBook
//
//  Created by Austin Brovick  on 12/2/17.
//  Copyright © 2017 Austin Brovick . All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var bookFileType: UITextField!
    @IBOutlet weak var mobileNetworkSwitch: UISwitch!
    
    var mobileNetwork = false
    
    let fileTypes = ["html", "kindle", "epub", "pdf"]
    
    var selectedType: String = ""
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: set to selected type
        selectedType = "default"
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        bookFileType.inputView = pickerView
        bookFileType.textAlignment = .center
        bookFileType.text = selectedType
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        mobileNetwork = sender.isOn
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fileTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fileTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = fileTypes[row]
        
        bookFileType.text = fileTypes[row]
        bookFileType.resignFirstResponder()
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
