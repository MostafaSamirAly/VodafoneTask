//
//  MainViewController.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import UIKit

class MainViewController: DataLoadingViewController {
    @IBOutlet weak var photosTableView: UITableView! {
        didSet {
            setupTableView()
        }
    }
    
    let viewModel = MainViewModel()
    let refreshControl = UIRefreshControl()
    let transition = TransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewmodel()
        setupRefreshControl()
    }
}

fileprivate extension MainViewController {
    func setupViewmodel() {
        viewModel.errorCompletion = { [weak self] error in
            self?.dismissLoadingView()
            self?.showAlert(message: error.localizedDescription)
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.photosTableView.reloadData()
            }
        }
        viewModel.successCompletion = { [weak self] in
            self?.dismissLoadingView()
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.photosTableView.reloadData()
            }
        }
        showLoadingView()
        viewModel.fetchData()
    }
    
    func setupTableView() {
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photosTableView.prefetchDataSource = self
        photosTableView.register(UINib(nibName: String(describing: PhotoTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PhotoTableViewCell.self))
        photosTableView.register(UINib(nibName: String(describing: AdTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AdTableViewCell.self))
        photosTableView.register(UINib(nibName: String(describing: LoadMoreTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LoadMoreTableViewCell.self))
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        photosTableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        refreshControl.beginRefreshing()
        viewModel.refresh()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !viewModel.isAd(at: indexPath),
           indexPath.row != (viewModel.lastIndex()) {
            if let infoVC = storyboard?.instantiateViewController(identifier: "InfoVC") as? InfoVC {
                viewModel.setSelectedPhoto(at: indexPath)
                infoVC.viewModel = viewModel
                infoVC.transitioningDelegate = self
                present(infoVC, animated: true, completion: nil)
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.totalCount()
        if count == 0 {
            tableView.setEmptyView(title: "", message: "No Photos available")
        }else {
            tableView.resetTableView()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.lastIndex() {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoadMoreTableViewCell.self),for: indexPath) as? LoadMoreTableViewCell else { return UITableViewCell() }
            return cell
        }else {
            if viewModel.isAd(at: indexPath) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdTableViewCell.self),for: indexPath) as? AdTableViewCell else { return UITableViewCell() }
                return cell
            }else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotoTableViewCell.self),for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
                cell.configure(with: viewModel.photo(at: indexPath))
                return cell
            }
        }
    }
}

extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let indexPath = indexPaths.last,
           indexPath.row == viewModel.lastIndex() {
            viewModel.loadMore()
        }
    }
}
