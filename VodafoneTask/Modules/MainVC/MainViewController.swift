//
//  MainViewController.swift
//  VodafoneTask
//
//  Created by Mostafa Samir on 25/07/2021.
//

import UIKit

class MainViewController: DataLoadingVC {
    private let viewmodel = MainViewmodel()
    @IBOutlet weak var photosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewmodel()
    }
    
    private func setupViewmodel() {
        viewmodel.errorCompletion = { [weak self] error in
            self?.dismissLoadingView()
            self?.showAlert(message: error.localizedDescription)
        }
        
        viewmodel.successCompletion = { [weak self] in
            self?.dismissLoadingView()
            DispatchQueue.main.async {
                self?.photosTableView.reloadData()
            }
        }
        
        showLoadingView()
        viewmodel.getData()
    }
    
    private func setupTableView() {
        photosTableView.delegate = self
        photosTableView.dataSource = self
        photosTableView.register(UINib(nibName: String(describing: PhotoTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: PhotoTableViewCell.self))
        photosTableView.register(UINib(nibName: String(describing: AdTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AdTableViewCell.self))
        photosTableView.register(UINib(nibName: String(describing: LoadMoreTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LoadMoreTableViewCell.self))
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewmodel.photos.count //+ viewmodel.numberOfAds
        return viewmodel.hasMore ? count + 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewmodel.photos.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoadMoreTableViewCell.self),for: indexPath) as? LoadMoreTableViewCell else { return UITableViewCell() }
            return cell
//        }else if indexPath.row % 5 == 0, indexPath.row != 0{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdTableViewCell.self),for: indexPath) as? AdTableViewCell else { return UITableViewCell() }
//            //cell.configure(with: viewmodel.photos[indexPath.row])
//            return cell
        }else {
            //let index = indexPath.row - (indexPath.row % 5)
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotoTableViewCell.self),for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
            cell.configure(with: viewmodel.photos[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let _ = cell as? LoadMoreTableViewCell {
            viewmodel.loadMore()
        }
    }
}
