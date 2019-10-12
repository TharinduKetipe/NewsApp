//
//  HomeViewController.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 10/8/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import MKProgress

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataImage: UIImageView!
    
    var news = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callWebService()
    }
    
    func configureUI() {
        noDataImage.isHidden = true
        self.navigationController?.navigationBar.topItem?.title = "Top News"
    }
    
    func callWebService() {
        MKProgress.show()
        APIClient.shared.topNews(country: "us") { (status, response) in
            MKProgress.hide()
            if status == APIClient.APIResponseStatus.Success {
                if (response?.news.count)! > 0 {
                    self.news = response!.news
                    self.tableView.reloadData()
                    self.noDataImage.isHidden = true
                } else {
                    self.noDataImage.isHidden = false
                }
            } else {
                self.noDataImage.isHidden = false
            }
        }
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = news[indexPath.row]
        let articleVC = self.storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        articleVC.article = article
        self.navigationController?.pushViewController(articleVC, animated: true)
    }
}

extension HomeViewController : UITableViewDataSource {
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
