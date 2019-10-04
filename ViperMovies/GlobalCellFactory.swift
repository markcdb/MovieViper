//
//  GlobalCellFactory.swift
//  Movie
//
//  Created by Mark Christian Buot on 14/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import UIKit

typealias CellFactory = GlobalCellFactory

class GlobalCellFactory {
    static func createLoaderCell(tableView: UITableView,
                                 indexPath: IndexPath) -> LoaderCell? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.loaderCell,
                                                 for: indexPath) as? LoaderCell
        
        cell?.selectionStyle = .none
        cell?.loadingIndicator.startAnimating()
        
        return cell
    }
    
    static func createErrorCell(tableView: UITableView,
                                indexPath: IndexPath) -> ErrorCell? {
        
        let id = Cells.errorCell
        let cell = tableView.dequeueReusableCell(withIdentifier: id) as? ErrorCell
        
        return cell
    }
    
    static func createMoviePreviewCell(presenter: MovieListPresenter?,
                                       tableView: UITableView,
                                       indexPath: IndexPath) -> MoviePreviewCell? {
        
        let id           = Cells.moviePreviewCell
        let title        = presenter?.getMovieTitleAt(indexPath.row)
        let popularity   = presenter?.getMoviePopularityAt(indexPath.row)
        let posterPath   = presenter?.getMoviePosterPathAt(indexPath.row)
        let backdropPath = presenter?.getBackdropPathAt(indexPath.row)
        let cell         = tableView.dequeueReusableCell(withIdentifier: id) as? MoviePreviewCell
        
        let posterUrl    = posterPath?.getImageUrlStringWith(cell?.posterImage?.frame.width)
        let backdropUrl  = backdropPath?.getImageUrlStringWith(cell?.backdropImage?.frame.width)
        
        cell?.setMovieImage(backdropUrl,
                            posterUrl: posterUrl)
        
        cell?.setWith(title: title ?? blank_,
                      subTitle: String(popularity ?? 0))
        return cell
    }
    
    static func createMovieHeaderCell(presenter: MovieDetailsPresenter?,
                                      tableView: UITableView,
                                      indexPath: IndexPath) -> MovieHeaderCell? {
        
        let id           = Cells.movieHeaderCell
        let posterPath   = presenter?.getMoviePosterPath()
        let backdropPath = presenter?.getBackdropPath()
        let title        = presenter?.getMovieTitle()
        let popularity   = presenter?.getMoviePopularity()

        //let duration     = viewMode
        let cell         = tableView.dequeueReusableCell(withIdentifier: id) as? MovieHeaderCell
        
        let posterUrl    = posterPath?.getImageUrlStringWith(cell?.posterImage?.frame.width)
        let backdropUrl  = backdropPath?.getImageUrlStringWith(cell?.backdropImage?.frame.width)
        
        cell?.setWith(title: title ?? blank_,
                      subTitle: String(popularity ?? 0.0))
        
        cell?.setMovieImage(backdropUrl,
                            posterUrl: posterUrl)
        
        return cell
    }
    
    static func createMovieDetailsCell(presenter: MovieDetailsPresenter?,
                                       tableView: UITableView,
                                       indexPath: IndexPath,
                                       delegate: MovieDetailsCellDelegate) -> MovieDetailsCell? {
        
        let id           = Cells.movieDetailsCell
        let sypnosis     = presenter?.getOverview() ?? blank_
        let genres       = presenter?.getGenreString() ?? blank_
        let languages    = presenter?.getSpokenLanguageString() ?? blank_
        let runtime      = presenter?.getRuntimeString()
        
        let cell         = tableView.dequeueReusableCell(withIdentifier: id) as? MovieDetailsCell
        
        cell?.sypnosisLabel?.text   = sypnosis.isEmpty == true ? "N/A" : sypnosis
        cell?.genresLabel?.text     = genres.isEmpty == true ? "n/a" : genres
        cell?.languagesLabel?.text  = languages.isEmpty == true ? "n/a" : languages
        cell?.durationLabel?.text   = runtime
        cell?.delegate              = delegate
        
        return cell
    }
    
    static func createMovieSimilarCell(presenter: MovieListPresenter?,
                                       tableView: UITableView,
                                       indexPath: IndexPath,
                                       delegate: MovieSimilarCellDelegate) -> MovieSimilarCell? {
        
        let id          = Cells.movieSimilarCell
        
        let cell        = tableView.dequeueReusableCell(withIdentifier: id) as? MovieSimilarCell
        cell?.presenter = presenter
        cell?.delegate  = delegate
        
        cell?.collectionView?.reloadSections([0])
        
        return cell
    }
    
    static func createSimilarCell(presenter: MovieListPresenter?,
                                  collectionView: UICollectionView,
                                  indexPath: IndexPath) -> SimilarCell? {
        
        let id          = Cells.similarCell
        let title       = presenter?.getMovieTitleAt(indexPath.row)
        let posterPath  = presenter?.getMoviePosterPathAt(indexPath.row)
        
        let cell          = collectionView.dequeueReusableCell(withReuseIdentifier: id,
                                                             for: indexPath) as? SimilarCell
        
        let posterUrl     = posterPath?.getImageUrlStringWith(cell?.imageView?.frame.width)
        cell?.title?.text = title
        cell?.setMovieImage(posterUrl: posterUrl)
        
        return cell
    }
    
    static func createLoaderCVCell(collectionView: UICollectionView,
                                   indexPath: IndexPath) -> LoaderCVCell? {
        
        let id          = Cells.loaderCVCell
        
        let cell        = collectionView.dequeueReusableCell(withReuseIdentifier: id,
                                                             for: indexPath) as? LoaderCVCell
        
        cell?.activityIndicator?.startAnimating()
        
        return cell
    }
}
