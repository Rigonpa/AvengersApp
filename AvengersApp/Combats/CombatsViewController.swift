//
//  CombatsViewController.swift
//  AvengersApp
//
//  Created by Ricardo González Pacheco on 25/04/2020.
//  Copyright © 2020 Ricardo González Pacheco. All rights reserved.
//

import UIKit

class CombatsViewController: UIViewController {
    
    // MARK: - Public properties
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = #colorLiteral(red: 0.9626390338, green: 0.9626776576, blue: 0.9913365245, alpha: 1)
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(CombatsCell.self, forCellReuseIdentifier: CombatsCell.cellIdentifier)
        return table
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.02531321719, green: 0.4073432684, blue: 0.903057158, alpha: 1)
        return view
    }()
    
    lazy var addButton: UIButton = {
        let label = UILabel()
        label.text = "¿NEW COMBAT?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: AvengersCell.avengersAppFont, size: 15)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.02531321719, green: 0.4073432684, blue: 0.903057158, alpha: 1)
        let btn = UIButton(type: .system)
        btn.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            label.widthAnchor.constraint(equalTo: btn.widthAnchor),
            label.heightAnchor.constraint(equalTo: btn.heightAnchor)
        ])
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = false
        btn.addTarget(self, action: #selector(handleAddCombat), for: .touchUpInside)
        return btn
    }()
    
    let viewModel: CombatsViewModel
    init(viewModel: CombatsViewModel) {
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
//        viewModel.showAllCombats()
//        print("\n\n")
//        viewModel.deleteAll()
//        print("Before\n\n\n")
        
        setupUI()
        viewModel.fetchCombats()
        
        print("After")
        viewModel.showAllCombats()
        print("\n\n")
        print("After")
    
    }
    
    // MARK: - Private methods
    
    private func updateUI() {
        tableView.reloadData()
    }
    
    private func setupUI() {
        navigationItem.title = "Combats"
        view.backgroundColor = #colorLiteral(red: 0.77372998, green: 0.8594649434, blue: 0.9724978805, alpha: 1)
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(separatorView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            separatorView.widthAnchor.constraint(equalTo: view.widthAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75),
            addButton.widthAnchor.constraint(equalToConstant: 300),
            addButton.topAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
    
    @objc func handleAddCombat() {
        if viewModel.newCombatButtonEnabled() {
            viewModel.onNewCombatRequested()
        } else {
            print("Busted")
        }
    }
}

// MARK: - Tableview methods
extension CombatsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CombatsCell.cellIdentifier, for: indexPath) as? CombatsCell,
            let cellViewModel = viewModel.oneCombatViewModel(indexPath) else { fatalError() }
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - View model communication
extension CombatsViewController: CombatsViewDelegate {
    func onshowingCombatsUpdates() {
        updateUI()
    }
}
