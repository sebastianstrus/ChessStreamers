//
//  DetailsView.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import UIKit

class DetailsView: UIView {
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - All subviews
    fileprivate let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "background1")
        return iv
    }()
    
    fileprivate var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate var urlLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    fileprivate var statusLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    // MARK: - Private functions
    fileprivate func setup() {
        backgroundColor = .white
        addSubview(imageView)
        
        imageView.setAnchor(top: topAnchor,
                            leading: leadingAnchor,
                            bottom: nil,
                            trailing: nil,
                            paddingTop: Device.IS_IPHONE ? 10 : 20,
                            paddingLeft: Device.IS_IPHONE ? 10 : 20,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: Device.IS_IPAD ? 120 : 60,
                            height: Device.IS_IPAD ? 120 : 60)
        
        addSubview(urlLabel)
        urlLabel.setAnchor(top: imageView.bottomAnchor,
                            leading: leadingAnchor,
                            bottom: nil,
                            trailing: trailingAnchor,
                            paddingTop: Device.IS_IPHONE ? 10 : 20,
                            paddingLeft: Device.IS_IPHONE ? 10 : 20,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0 ,
                            height: Device.IS_IPAD ? 120 : 60)
        
        addSubview(statusLabel)
        statusLabel.setAnchor(top: urlLabel.bottomAnchor,
                            leading: leadingAnchor,
                            bottom: nil,
                            trailing: trailingAnchor,
                            paddingTop: Device.IS_IPHONE ? 10 : 20,
                            paddingLeft: Device.IS_IPHONE ? 10 : 20,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 0 ,
                            height: Device.IS_IPAD ? 120 : 60)
    }
    
    // MARK: - Public functions
    func setStreamer(streamer: Streamer) {
        imageView.load(url: URL(string: streamer.avatarUrl)!)
        urlLabel.text = streamer.url
        statusLabel.text = streamer.isLive ? "Streamer is available" : "Streamer is not available"
        statusLabel.textColor = streamer.isLive ? UIColor.green : UIColor.red
    }
    
    
    
}
