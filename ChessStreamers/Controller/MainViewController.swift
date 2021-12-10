//
//  MainViewController.swift
//  ChessStreamers
//
//  Created by Sebastian Strus on 2021-12-10.
//

import UIKit
import Combine


class MainViewController: UICollectionViewController {

    fileprivate let cellId = "cellId"
    private var streamersCancellable: AnyCancellable? = nil
    
    var streamers: [Streamer] = [] {
        didSet {
            print(streamers)
            
            print("Count: \(streamers.count)")
            collectionView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView?.register(StreamerCell.self, forCellWithReuseIdentifier: cellId)
        
        getStreamers()
    }
    
    // MARK: - Initializers
       init() {
           print("initializer")
           super.init(collectionViewLayout: FlowLayout(cellsPerRow: Device.IS_IPAD ? 8 : 4,
                                                       minimumInteritemSpacing: 4,
                                                       minimumLineSpacing: 4,
                                                       sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
       }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
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
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StreamerCell
        cell.configureCell(streamer: streamers[indexPath.row])
        cell.backgroundColor = UIColor.gray

        return cell
    }
}


class FlowLayout: UICollectionViewFlowLayout {

    let cellsPerRow: Int

    required init(cellsPerRow: Int = 1, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow = cellsPerRow

        super.init()

        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }
        guard let collectionView = collectionView else { return layoutAttributes }

        let marginsAndInsets = collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + sectionInset.left + sectionInset.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        layoutAttributes.bounds.size.width = ((collectionView.bounds.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)

        return layoutAttributes
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let superLayoutAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
        guard scrollDirection == .vertical else { return superLayoutAttributes }

        let layoutAttributes = superLayoutAttributes.compactMap { layoutAttribute in
            return layoutAttribute.representedElementCategory == .cell ? layoutAttributesForItem(at: layoutAttribute.indexPath) : layoutAttribute
        }

        return layoutAttributes
    }

}
