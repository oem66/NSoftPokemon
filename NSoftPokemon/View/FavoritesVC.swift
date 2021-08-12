//
//  FavoritesVC.swift
//  NSoftPokemon
//
//  Created by Omer Rahmanovic on 6/29/21.
//

import Foundation
import UIKit

class FavoritesVC: UIViewController, UIConfigurationProtocol {
    
    var tableView = UITableView()
    var viewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        viewModel.fetchFromCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        setupTableView()
        viewModel.fetchFromCoreData()
        tableView.reloadData()
    }
    
    func setupUI() {
        setNavigation()
        addSubviews()
    }
    
    func setNavigation() {
        title = SBString.fs_title
        view.backgroundColor = .tertiarySystemBackground
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: SBString.back_button, style: .plain, target: nil, action: nil)
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        setConstraints()
    }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setupTableView() {
        setTableViewDelegates()
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.rowHeight = 100.0
        tableView.register(PokemonCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.separatorStyle = .none
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func refreshTableViewOnNotification(notification: NSNotification) {
        setupUI()
        setupTableView()
        viewModel.fetchFromCoreData()
    }
}

extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as? PokemonCell else { return UITableViewCell() }
        cell.configureCell(viewModel.pokemons[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = viewModel.pokemons[indexPath.row]
            PersistanceService.context.delete(pokemon)
            PersistanceService.saveContext()
            
            viewModel.pokemons.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PokemonCDDetailsVC()
        vc.viewModel.pokemonName = viewModel.pokemons[indexPath.row].name ?? "No name"
        vc.viewModel.pokemon = viewModel.pokemons[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
