//
//  StoryCell.swift
//  NextappTechTask
//
//  Created by Oleksandr Vaker on 20/09/2020.
//

import UIKit
import AVFoundation
import AVKit
import RxSwift
import RxCocoa
import SDWebImage

class StoryCell: UICollectionViewCell {
    @IBOutlet private weak var playerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var dismissButton: UIButton!
    @IBOutlet private weak var avatarImage: UIImageView! {
        didSet {
            avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
        }
    }
    
    private func setSegmentedProgressBar(with duration: TimeInterval = 5.0) -> SegmentedProgressBar {
        let spb = SegmentedProgressBar(numberOfSegments: 1, duration: duration)
        spb.frame = CGRect(x: 15, y: 20, width: bounds.width - 30, height: 4)
        spb.startAnimation()
        return spb
    }
    
    private var spb: SegmentedProgressBar?
    private var player: AVPlayer?
    private var avPlayerLayer: AVPlayerLayer?
    fileprivate var segmentEnded: (() -> Void)?
    private var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareForReuse()
        layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        player = nil
        avPlayerLayer?.removeFromSuperlayer()
        avatarImage.image = nil
        nameLabel.text = nil
        imageView.image = nil
        spb?.removeFromSuperview()
        segmentEnded = nil
        disposeBag = DisposeBag()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerView.frame = bounds
        avPlayerLayer?.frame = bounds
    }
    
    func setupUI(with story: Story, viewModel: PreviewViewModel) {
        if let urlPath = story.feed_preview_video, let url = URL(string: urlPath) {
            setupPlayer(with: url)
            if let spb = spb { contentView.addSubview(spb) }
        } else {
            imageView.sd_setImage(with: URL(string: story.cover_src))
        }
        avatarImage.sd_setImage(with: URL(string: story.user.avatar_image_url))
        nameLabel.text = story.user.display_name
        
        viewModel.selectedItem
            .drive(onNext: { [weak self] dto in
                guard let self = self else { return }
                if dto.item == story {
                    self.player?.play()
                } else {
                    self.player?.pause()
                }
            }).disposed(by: disposeBag)
        
        dismissButton.rx.tap
            .bind(to: viewModel.dismissButtonPressed)
            .disposed(by: disposeBag)
    }
    
    private func setupPlayer(with url: URL) {
        let asset = AVAsset(url: url)
        let durationTime = CMTimeGetSeconds(asset.duration)
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        avPlayerLayer = AVPlayerLayer(player: player)
        avPlayerLayer?.frame = UIScreen.main.bounds
        avPlayerLayer?.videoGravity = .resizeAspectFill
        if let layer = avPlayerLayer {
            playerView.layer.addSublayer(layer)
        }
        player?.play()
        spb = setSegmentedProgressBar(with: durationTime)
    }
}
