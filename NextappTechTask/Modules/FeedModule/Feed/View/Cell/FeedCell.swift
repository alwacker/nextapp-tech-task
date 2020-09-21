//
//  FeedCell.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 20/09/2020.
//

import UIKit
import SDWebImage

extension UIView {
    func cornerRadius(usingCorners corners: UIRectCorner, cornerRadii: CGSize) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}

class FeedCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var likesStackView: UIStackView!
    @IBOutlet private weak var numberOfLikesLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    
   
    func setupUI(with story: Story) {
        imageView.sd_setImage(with: URL(string: story.cover_src))
        likesStackView.isHidden = story.likes.count == 0
        numberOfLikesLabel.text = String(story.likes.count)
        authorLabel.text = story.user.display_name
    }

}
