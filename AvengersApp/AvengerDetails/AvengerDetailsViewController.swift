//
//  AvengersDetailViewController.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 27/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class AvengerDetailsViewController: UIViewController {
    
    // MARK: - Public properties
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = false
        table.register(ImageCell.self, forCellReuseIdentifier: ImageCell.cellIndentifier)
        table.register(PowerCell.self, forCellReuseIdentifier: PowerCell.cellIndentifier)
        table.register(CombatsTrackCell.self, forCellReuseIdentifier: CombatsTrackCell.cellIndentifier)
        table.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.cellIndentifier)
        table.separatorStyle = .none
        table.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        return table
    }()
    
    var heroesSection: Bool?
    
    let viewModel: AvengerDetailsViewModel
    init(viewModel: AvengerDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        heroesSection = viewModel.heroesSection()
        navigationItem.title = viewModel.navigationItemTitle()
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableViewMethods
extension AvengerDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.heightCell(in: indexPath))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel.setDetailViewModel(indexPath: indexPath) else { fatalError() } // Common factor
        switch indexPath.row {

        // ImageCell
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ImageCell.cellIndentifier, for: indexPath) as? ImageCell else { fatalError() }
            cell.viewModel = cellViewModel as? ImageCellViewModel
            return cell
            
        // PowerCell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PowerCell.cellIndentifier, for: indexPath) as? PowerCell else { fatalError() }
            cell.viewModel = cellViewModel as? PowerCellViewModel
            return cell
            
        // CombatsCell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CombatsTrackCell.cellIndentifier, for: indexPath) as? CombatsTrackCell else { fatalError() }
            cell.viewModel = cellViewModel as? CombatsTrackCellViewModel
            return cell
            
        // DescriptionCell
        default:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DescriptionCell.cellIndentifier, for: indexPath) as? DescriptionCell else { fatalError() }
            cell.viewModel = cellViewModel as? DescriptionCellViewModel
            return cell
        }
    }
}

// MARK: - View model communication
extension AvengerDetailsViewController: AvengerDetailsViewDelegate {
    
}
