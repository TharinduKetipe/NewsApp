//
//  CustomNewsViewController.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 10/8/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import MKProgress

class CustomNewsViewController: UIViewController {
    
    @IBOutlet weak var txtNewsType: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataImage: UIImageView!
    
    var keyWordPicker = UIPickerView()
    
    var pickeData = [String]()
    var news = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        configurePickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callInitialWebService()
    }
    
    func configureData() {
        pickeData = ["bitcoin", "apple", "earthquake", "animal" ]
        self.navigationController?.navigationBar.topItem?.title = "Search Favourites"
    }
    
    func callInitialWebService(){
        if txtNewsType.text!.isEmpty {
            txtNewsType.text = pickeData[0]
        }
        callWebService(keyword: txtNewsType.text!)
    }
    
    func configurePickerView() {
        keyWordPicker.delegate = self
        keyWordPicker.dataSource = self
        txtNewsType.inputView = keyWordPicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.didTapToolBarDone))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.didTapToolBarCancel))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                    target: nil,
                                    action: nil);
        toolBar.setItems([cancelButton, space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        txtNewsType.inputAccessoryView = toolBar
        self.noDataImage.isHidden = true
    }
}

extension CustomNewsViewController {
    
    @objc func didTapToolBarDone() {
        self.txtNewsType.resignFirstResponder()
        if txtNewsType.text!.isEmpty {
            txtNewsType.text = pickeData[0]
        }
        callWebService(keyword: txtNewsType.text!)
    }
    
    @objc func didTapToolBarCancel() {
        self.txtNewsType.resignFirstResponder()
    }
    
    func callWebService(keyword:String) {
        self.news.removeAll()
        MKProgress.show()
        APIClient.shared.newsByKeyword(keyword: keyword) { (status, response) in
            MKProgress.hide()
            if status == APIClient.APIResponseStatus.Success {
                if (response?.news.count)! > 0 {
                    self.news = response!.news
                    self.noDataImage.isHidden = true
                } else {
                    self.noDataImage.isHidden = false
                }
                self.tableView.reloadData()
            } else {
                self.noDataImage.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
}

extension CustomNewsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.txtNewsType.text = pickeData[row]
    }
}

extension CustomNewsViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickeData[row]
    }
}

extension CustomNewsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = news[indexPath.row]
        let articleVC = self.storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        articleVC.article = article
        self.navigationController?.pushViewController(articleVC, animated: true)
    }
}

extension CustomNewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath as IndexPath) as! NewsCell
        let article = news[indexPath.row]
        cell.setData(news: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
