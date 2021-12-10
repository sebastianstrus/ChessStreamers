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


    // MARK: - private functions
    private func setup() {
        backgroundColor = UIColor.green
    }
}
