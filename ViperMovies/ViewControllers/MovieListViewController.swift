//
//  MovieListViewController.swift
//  Movie
//
//  Created by Mark Christian Buot on 10/07/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import UIKit

class MovieListViewController: BaseTableViewController<MovieListViewModel>,
UITableViewDelegate,
UITableViewDataSource {

    let cellIdentifiers = [Cells.loaderCell,
                           Cells.errorCell,
                           Cells.moviePreviewCell]
    
    var selectedIndex: IndexPath? {
        didSet {
            push()
        }
    }

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
        viewModel                  = VMFactory.createMovieListVM(delegate: self)
        viewModel?.request()
    }
    
    override func push() {
        super.push()
        
        guard let indexPath = selectedIndex else { return }
        
        let index = indexPath.row
        
        if let id = viewModel?.getMovieIdAt(index),
            let vc = GlobalVCFactory.createMovieDetailsWithId(id) {
            
            navigationController?.pushViewController(vc,
                                                     animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if viewModel?.viewState.value == .error(nil) {
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
        
        let count = viewModel?.getMovieCount() ?? 0
        
        if count > 0 {
            return count
        }
        
        if viewModel?.viewState.value == .error(nil) {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        switch viewModel?.viewState.value {
        case .success(_)?:
            cell = CellFactory.createMoviePreviewCell(presenter: viewModel,
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
        
        selectedIndex = indexPath
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1),
            viewModel?.viewState.value != .loading(nil) {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.viewModel?.request()
            }
        }
    }
}

//MARK: - Custom methods
extension MovieListViewController {
    
    @objc func pullRefresh() {
        guard let state = viewModel?.viewState.value else { return }
        guard state != .loading(nil) else {
                tableView?.endRefreshing()
                return
        }
        
        tableView?.beginRefreshing()
        viewModel?.resetPage()
        viewModel?.request()
    }
}

//MARK: - View model delegate
extension MovieListViewController: BaseVMDelegate {
    
    func didUpdateModelWithState(_ viewState: ViewState) {
        switch viewState {
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
