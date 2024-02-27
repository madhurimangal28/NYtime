//
//  HomeViewController.swift
//  NYTimes
//
//  Created by Madhuri Agarwal on 20/02/24.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet private weak var itemTableView: UITableView!
    private var viewModel: HomeViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
        defaultSetup()
        
    }
    private func defaultSetup() {
        self.title = "homeNavTitle".localized()
        viewModel = HomeViewModel()
        viewModel?.delegate = self
        self.activityLoader.startAnimating()
        viewModel?.fetchMostPopularNews()
    }
    private func setupCell() {
        let cellXIB = UINib.init(nibName: NewsTableViewCell.identifier, bundle: .main)
        itemTableView.register(cellXIB, forCellReuseIdentifier: NewsTableViewCell.identifier)
        itemTableView.dataSource = self
        itemTableView.delegate = self
        itemTableView.accessibilityIdentifier = "articleListTableView".localized()
        activityLoader.accessibilityIdentifier = "loader"
    }
    
    deinit {
        viewModel = nil
    }
    
    // MARK: - tableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.newsItems?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.accessibilityIdentifier = "cell\(indexPath.row)"
        if let dataModel = viewModel?.newsItems?[indexPath.row] {
            
            if let photo = self.viewModel?.photos.first(where: {$0.id == "\(dataModel.id ?? 0)"}) {
                cell.configuration(with: dataModel, profilePhoto: photo)
                viewModel?.startOperations(photoRecord: photo)
            }
        }
        return cell
    }
    
}

extension HomeViewController: HomePageDelegate {
    func updateView(_ error: String?) {
        DispatchQueue.main.async {
            self.activityLoader.stopAnimating()
            self.itemTableView.reloadData()
            if !(error?.isEmpty ?? true) {
                self.showToast(message: error ?? "apiError".localized())
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleInfo = self.viewModel?.newsItems?[indexPath.row]
        let viewModel = ArticleDetailViewModel(articleInfo)
        let detailSscreen = self.storyboard?.instantiateViewController(identifier: String(describing: ArticleDetailViewController.self)) { creator in
            let viewController = ArticleDetailViewController(viewModel, coder: creator)
            viewModel.delegate = viewController
            return viewController
        }
        if let nextScreen = detailSscreen {
            self.navigationController?.pushViewController(nextScreen, animated: true)
        }
    }
}
