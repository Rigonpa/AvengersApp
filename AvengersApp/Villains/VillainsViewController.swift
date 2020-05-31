//
//  VillainsViewController.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class VillainsViewController: UIViewController {
    
    // MARK:- Public properties
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = #colorLiteral(red: 0.8773142695, green: 0.8238069415, blue: 0.9192584157, alpha: 1)
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.register(AvengersCell.self, forCellReuseIdentifier: AvengersCell.cellIdentifier)
        return table
    }()
    
    let viewModel: VillainsViewModel
    init(viewModel: VillainsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("Before")
//        print("\n\n")
//        viewModel.showAllVillains()
//        viewModel.deleteAll()
//        print("Before\n\n\n")
        
        setupUI()
        viewModel.viewDidLoad()
        
//        print("After")
//        print("\n\n")
//        viewModel.showAllVillains()
//        print("After")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(tabBarController?.selectedIndex, forKey: "LastScreen")
    }
    
    // MARK: - Private methods
    private func setupUI() {
        navigationItem.title = "Villains"
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    fileprivate func updateUI() {
        tableView.reloadData()
    }
}

// MARK: - Tableview methods
extension VillainsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !UserDefaults.standard.bool(forKey: "Presenting villain module") {
            viewModel.didSelectRow(indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AvengersCell.cellIdentifier, for: indexPath) as? AvengersCell,
            let cellViewModel = viewModel.oneVillainViewModel(indexPath) else { fatalError() }
        cell.villainsViewModel = cellViewModel
        return cell
    }
}

// MARK: - View model communication
extension VillainsViewController: VillainsViewDelegate {
    func onVillainPowerWasUpdated() {
        updateUI()
    }
}
