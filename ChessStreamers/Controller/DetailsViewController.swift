//
//  DetailsViewController.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import UIKit

class DetailsViewController: UIViewController {

    fileprivate var detailsView: DetailsView!
    var streamer: Streamer? = nil


    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private functions
        fileprivate func setupNavigationBar() {
            navigationItem.title = streamer?.username
            let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            

        }

        fileprivate func setupLayout() {
            detailsView = DetailsView(frame: view.frame)
            view.addSubview(detailsView)
            detailsView.setStreamer(streamer: streamer!)
        }
      

    

}
