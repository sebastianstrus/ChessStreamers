//
//  MainViewController.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import UIKit
import Combine

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    

    fileprivate var mainView: MainView!
    fileprivate let cellId = "cellId"
    
    var streamers: [Streamer] = [] {
        didSet {
            print(streamers)
            
            print("Count: \(streamers.count)")
            mainView.reload()
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
        mainView.setDelegate(delegate: self)
        mainView.setDataSource(delegate: self)
        mainView.registerCell(className: StreamerCell.self, id: cellId)
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
    
    // MARK: - UICollectionViewDataSource functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StreamerCell
        cell.streamer = streamers[indexPath.row]
        cell.backgroundColor = UIColor.gray

        return cell
    }


}

