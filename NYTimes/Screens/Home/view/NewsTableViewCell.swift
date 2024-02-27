//
//  NewsTableViewCell.swift
//  NYTimes
//
//  Created by Madhuri Agrawal on 20/02/24.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var newsThumb: UIImageView!
    @IBOutlet private weak var articleDateLabel: UILabel!
    @IBOutlet private weak var autherNameLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        autherNameLabel.accessibilityIdentifier = "label_name"
        newsThumb.accessibilityIdentifier = "thumb_image"
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        newsThumb.layer.cornerRadius = 20
        newsThumb.layer.masksToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var identifier = String(describing: NewsTableViewCell.self)
    
    func configuration(with model: NewsDetailInfo?, profilePhoto: ProfilePhoto?) {
        self.titleLabel.text = model?.title
        self.autherNameLabel.text = model?.byline
        self.articleDateLabel.text = model?.dateWithIcon
        newsThumb.image = profilePhoto?.image
        
    }
}
