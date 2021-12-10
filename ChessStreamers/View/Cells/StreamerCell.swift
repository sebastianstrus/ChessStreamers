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
            setStreamer(streamer: streamer!)
        }
    }

    let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private functions
    func setupLayout() {
        addSubview(imageView)
        imageView.pinToEdges(view: self, safe: false)
    }
    
    // MARK: - public functions
    func setStreamer(streamer: Streamer) {
        
        //imageView.image = streamer.image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setupLayout()
    }
}
