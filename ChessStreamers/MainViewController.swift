//
//  MainViewController.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import UIKit

class MainViewController: UIViewController {

    fileprivate var mainView: MainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.mainView = MainView(frame: view.frame)
        view.addSubview(mainView)

        
    }


}

