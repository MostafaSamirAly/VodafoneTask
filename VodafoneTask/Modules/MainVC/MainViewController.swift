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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !viewmodel.isAd(at: indexPath),
           indexPath.row != (viewmodel.photos.count + viewmodel.numberOfAds) {
            if let infoVC = storyboard?.instantiateViewController(identifier: "InfoVC") as? InfoVC {
                infoVC.viewmodel.photo = viewmodel.getPhoto(at: indexPath)
                pushCrossDissolve(viewController: infoVC)
            }
        }
        
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewmodel.photos.count + viewmodel.numberOfAds
        return viewmodel.hasMore ? count + 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewmodel.photos.count + viewmodel.numberOfAds {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoadMoreTableViewCell.self),for: indexPath) as? LoadMoreTableViewCell else { return UITableViewCell() }
            return cell
        }else {
            if viewmodel.isAd(at: indexPath) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AdTableViewCell.self),for: indexPath) as? AdTableViewCell else { return UITableViewCell() }
                return cell
            }else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotoTableViewCell.self),for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
                cell.configure(with: viewmodel.getPhoto(at: indexPath))
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let _ = cell as? LoadMoreTableViewCell {
            viewmodel.loadMore()
        }
    }
}
