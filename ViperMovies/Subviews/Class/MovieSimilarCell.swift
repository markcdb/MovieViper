//
//  MovieSimilarCell.swift
//  Movie
//
//  Created by Mark Christian Buot on 18/08/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

protocol MovieSimilarCellDelegate: class {
    
    func didTapCellWithId(_ id: Int)
    func fetchNewPage()
}

class MovieSimilarCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView?
    
    var scrollOffset: CGPoint?
    var presenter: MovieListPresenter?
    weak var delegate: MovieSimilarCellDelegate?
    
    let cells = [Cells.similarCell,
                Cells.loaderCVCell]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView?.delegate   = self
        collectionView?.dataSource = self
        
        for cell in cells {
            collectionView?.register(UINib(nibName: cell,
                                           bundle: nil),
                                     forCellWithReuseIdentifier: cell)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MovieSimilarCell: UICollectionViewDelegate, UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let count = presenter?.getMovieCount() ?? 0
        
        if presenter?.movieSorter?.isLastPage == true {
            return count
        }
        
        return count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell?
        
        let count = presenter?.getMovieCount() ?? 0
        
        if count > 0,
            indexPath.row == count {
            //return pager
            cell = CellFactory.createLoaderCVCell(collectionView: collectionView,
                                                  indexPath: indexPath)
        } else {
            cell = CellFactory.createSimilarCell(presenter: presenter,
                                                 collectionView: collectionView,
                                                 indexPath: indexPath)

        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let id = presenter?.getMovieIdAt(indexPath.row)
        
        delegate?.didTapCellWithId(id ?? 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        self.scrollOffset = scrollView.contentOffset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let indexPath = collectionView?.indexPathsForVisibleItems.maxLog() else {
            return
        }
        
        let count = presenter?.getMovieCount() ?? 0
        if count > 0,
            indexPath.row == count {
            delegate?.fetchNewPage()
        }
    }
}
