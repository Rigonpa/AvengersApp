//
//  HeroesViewController.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class HeroesViewController: UIViewController {
    
    // MARK:- Public properties
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = #colorLiteral(red: 0.77372998, green: 0.8594649434, blue: 0.9724978805, alpha: 1)
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.register(AvengersCell.self, forCellReuseIdentifier: AvengersCell.cellIdentifier)
        return table
    }()
    
    let viewModel: HeroesViewModel
    init(viewModel: HeroesViewModel) {
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
//        viewModel.showAllHeroes()
//        print("\n\n")
//        viewModel.deleteAll()
//        print("Before\n\n\n")
        
        setupUI()
        viewModel.viewDidLoad()
        
//        viewModel.showAllCombats()
        
//        print("After")
//        viewModel.showAllHeroes()
//        print("\n\n")
//        print("After")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(tabBarController?.selectedIndex, forKey: "LastScreen")
    }
    
    // MARK: - Private methods
    private func setupUI() {
        navigationItem.title = "Superheroes"
        
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
extension HeroesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !UserDefaults.standard.bool(forKey: "Presenting heroe module") {
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
            let cellViewModel = viewModel.oneHeroeViewModel(indexPath) else { fatalError() }
        cell.heroesViewModel = cellViewModel
        return cell
    }
}

// MARK: - View model communication
extension HeroesViewController: HeroesViewDelegate {
    func onHeroePowerWasUpdated() {
        updateUI()
    }
}
