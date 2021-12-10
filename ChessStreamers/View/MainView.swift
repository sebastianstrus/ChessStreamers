//
//  MainView.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import UIKit

class MainView: UIView {

    // MARK: - Initializers
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    
    // MARK: - All subviews
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    

    // MARK: - private functions
    private func setup() {
        backgroundColor = UIColor.green
        addSubview(collectionView)
        collectionView.pinToEdges(view: self, safe: true)
    }
    
    // MARK: - Public functions
    func reload() {
        collectionView.reloadData()
    }
    
    func setDelegate(delegate: UICollectionViewDelegate) {
        collectionView.delegate = delegate
    }
    
    func setDataSource(delegate: UICollectionViewDataSource) {
        collectionView.dataSource = delegate
    }
    
    func registerCell(className: AnyClass, id: String) {
        collectionView.register(className, forCellWithReuseIdentifier: id)
    }
}
