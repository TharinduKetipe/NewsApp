//
//  ArticleViewController.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 10/12/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit
import WebKit

class ArticleViewController: UITableViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var lblLink: UILabel!
    
    public var article:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarCustomization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateData(article: self.article!)
    }
    
    func populateData(article:Article) {
        if let imgUrl = article.thumbImage {
            Utilities.downloadImage(url: imgUrl, imageView: mainImage)
        }
        lblTitle.text = article.title
        let date = article.publishedDate?.dateFromIsoString()
        lblDate.text = date?.toString(dateFormat: "yyyy-MM-dd HH:mm:ss")
        if let author = article.author {
            lblAuthor.text = "- " + author + " -"
        }
        lblContent.text = article.content
        lblSource.text = article.sourceName
        lblLink.text = article.articleUrl
    }
    
    func navBarCustomization() {
        let backImage = UIImage(named: "nav-back")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
        case 1:
            if let titleTxt = article?.title {
                return (titleTxt.height(withConstrainedWidth: lblTitle.frame.width, font: lblTitle.font))
            } else {
                return 0
            }
        case 2:
            return 85
        case 3:
            if let contentTxt = article?.content {
                return (contentTxt.height(withConstrainedWidth: lblContent.frame.width, font: lblContent.font))
            } else {
                return 0
            }
        case 4:
            return 40
        case 5:
            return 80
        default:
            return 60
        }
    }

    @IBAction func didTapLink(_ sender: Any) {
        if let artUrl = self.article!.articleUrl {
            guard let url = URL(string: artUrl) else { return }
            UIApplication.shared.open(url)
        }
    }
}
