//
//  MovieListViewController.swift
//  Movie
//
//  Created by Mark Christian Buot on 10/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class MovieListViewController: BaseTableViewController<MovieListPresenter>,
UITableViewDelegate,
UITableViewDataSource {

    let cellIdentifiers = [Cells.loaderCell,
                           Cells.errorCell,
                           Cells.moviePreviewCell]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = Titles.movies

        for id in cellIdentifiers {
            tableView?.register(UINib(nibName: id,
                                      bundle: .main),
                                forCellReuseIdentifier: id)
        }
        
        tableView?.delegate        = self
        tableView?.dataSource      = self
        tableView?.tableFooterView = ViewFactory.createFooterLoaderView(tableView)
        tableView?.refreshControl  = ViewFactory.createRefreshControler(self,
                                                                        action: #selector(pullRefresh))
        presenter                  = PresenterFactory.createMovieListPresenterFromVC(self)
        presenter?.request()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if presenter?.state == .error(nil) {
            return tableView.frame.height
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        let rows = presenter?.numberOfRows(section) ?? 0
        
        if rows > 0 {
            return rows
        }
        
        if presenter?.state == .error(nil) {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        switch presenter?.state {
        case .success(_)?:
            cell = CellFactory.createMoviePreviewCell(presenter: presenter,
                                                      tableView: tableView,
                                                      indexPath: indexPath)
        
        case .error(_)?:
            cell = CellFactory.createErrorCell(tableView: tableView,
                                               indexPath: indexPath)
        default:
            break
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath,
                              animated: true)
        
        presenter?.pushFromRow(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1),
            presenter?.state != .loading(nil) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.presenter?.request()
            }
        }
    }
}

//MARK: - Custom methods
extension MovieListViewController {
    
    @objc func pullRefresh() {
        guard let state = presenter?.state else { return }
        guard state != .loading(nil) else {
                tableView?.endRefreshing()
                return
        }
        
        tableView?.beginRefreshing()
        presenter?.resetPage()
        presenter?.request()
    }
}

//MARK: - View model delegate
extension MovieListViewController: MovieListPresenterDelegate {
    
    func didUpdatePresenterWithState(_ state: ViewState) {
        switch state {
        case .success(_):
            tableView?.endRefreshing()
            tableView?.reloadData()
        case .error(_):
            tableView?.endRefreshing()
            tableView?.reloadData()
        default:
            break
        }
    }
}
