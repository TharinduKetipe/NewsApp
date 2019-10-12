//
//  NewsCell.swift
//  TestApplication
//
//  Created by Tharindu Ketipearachchi on 10/9/19.
//  Copyright © 2019 Tharindu Ketipearachchi. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func setData(news:Article) {
        lblTitle.text = news.title
        let date = news.publishedDate?.dateFromIsoString()
        lblDate.text = date?.toString(dateFormat: "yyyy-MM-dd HH:mm:ss")
        lblSource.text = news.sourceName
        if let imgUrl = news.thumbImage {
            Utilities.downloadImage(url: imgUrl, imageView: imgThumbnail)
        }
    }
    
    func addShadow() {
    self.bgView.layer.cornerRadius = 10
    self.bgView.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.bgView.layer.shadowRadius = 5
    self.bgView.layer.shadowOpacity = 0.45
    self.bgView.layer.shouldRasterize = true
    self.bgView.layer.rasterizationScale = UIScreen.main.scale
    }
}
