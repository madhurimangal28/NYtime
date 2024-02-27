//
//  ArticleDetailViewController.swift
//  NYTimes
//
//  Created by Madhuri Agrawal on 21/02/24.
//

import UIKit

class ArticleDetailViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel: ArticleDetailViewModel?
    init?(_ viewModel: ArticleDetailViewModel?, coder: NSCoder) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
        defaultSetup()
    }
    
    private func defaultSetup() {
        self.title = "detailNavTitle".localized()
    }
    private func setupCell() {
        let cellXIB = UINib.init(nibName: ArticleDetailTableViewCell.identifier, bundle: .main)
        tableView.register(cellXIB, forCellReuseIdentifier: ArticleDetailTableViewCell.identifier)
        tableView.dataSource = self
        tableView.accessibilityIdentifier = "articleDetailTableView".localized()
    }
    
    deinit {
        viewModel = nil
    }
    
    // MARK: - tableView data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleDetailTableViewCell.identifier, for: indexPath) as? ArticleDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.accessibilityIdentifier = "detailCell\(indexPath.row)"
        cell.configuration(with: viewModel?.model)
        viewModel?.startOperations()
        return cell
    }
}

extension ArticleDetailViewController: HomePageDelegate {
    func updateView(_ error: String?) {
        DispatchQueue.main.async {
           self.tableView.reloadData()
        }
    }
}
