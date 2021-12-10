//
//  StreamerCell.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import UIKit



class StreamerCell: UICollectionViewCell {
    
    
    var streamer : Streamer? {
        didSet {
            configureCell(streamer: streamer!)
        }
    }

    
    // MARK: - All subviews
    fileprivate var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubview(imageView)
        
        imageView.setAnchor(top: contentView.layoutMarginsGuide.topAnchor,
                            leading: contentView.layoutMarginsGuide.leadingAnchor,
                            bottom: contentView.layoutMarginsGuide.bottomAnchor,
                            trailing: contentView.layoutMarginsGuide.trailingAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0,
                            height: self.frame.width*1.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        layoutAttributes.bounds.size.height = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    // MARK: - public functions
    func configureCell(streamer: Streamer) {
        
        imageView.load(url: URL(string: streamer.avatarUrl)!)
    }
    
    // MARK: - private functions
    private func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
}
