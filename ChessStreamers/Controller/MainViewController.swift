//
//  MainViewController.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import UIKit
import Combine

class MainViewController: UIViewController {

    fileprivate var mainView: MainView!
    
    var streamers: [Streamer] = [] {
        didSet {
            print(streamers)
            
            print("Count: \(streamers.count)")
        }
    }
    
    private var streamersCancellable: AnyCancellable? = nil
    
    // MARK: - View functions
    override func viewDidLoad() {
        super.viewDidLoad()
        getStreamers()
        
        setupView()
    }
    
    // MARK: - private functions
    private func setupView() {
        self.mainView = MainView(frame: view.frame)
        view.addSubview(mainView)
    }
    
    private func getStreamers() {
        self.streamersCancellable = StreamersAPIService.getStreamers()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion
                {
                case .failure(let error):
                    self.presentMessage("Error fetching streamers", message: error.localizedDescription)
                    // TODO: get streamers from CoreData
                    
                case .finished:
                    print("Finished")
                    break
                }
            }, receiveValue: { [unowned self] fetchedObject in
                streamers = fetchedObject["streamers"] ?? []
                // TODO: update core data
            })
        
    }


}

