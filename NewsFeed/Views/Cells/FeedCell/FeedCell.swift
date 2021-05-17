//
//  FeedCell.swift
//  NewsFeed
//
//  Created by Pierre Younes on 5/14/21.
//

import UIKit

class FeedCell: UITableViewCell {
    static let identifier = "FeedCell"

    @IBOutlet weak var imageViewNews: UIImageView!
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configureCell(vm: FeedCellVM, isDownloaded: Bool = false) {
        self.btnDownload.isHidden = isDownloaded
        lblNewsTitle.text = vm.title

        if let data = vm.imageData {
            self.imageViewNews.image = UIImage(data: data)
        } else if let url = URL(string: vm.urlToImage ?? "" ) {
            self.btnDownload.isHidden = true
            NewsFeedServices.shared.downloadImage(url: url) { [weak self] (data, error) in
                guard let data = data, error == nil else { return }
                vm.imageData = data
                self?.imageViewNews.image = UIImage(data: data)
            }
        }
    }
    
}
