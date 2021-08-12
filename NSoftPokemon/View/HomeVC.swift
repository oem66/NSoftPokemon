//
//  HomeVC.swift
//  NSoftPokemon
//
//  Created by Omer Rahmanovic on 6/28/21.
//

import UIKit
import Network
import SnapKit

class HomeVC: UIViewController, UIConfigurationProtocol {
    
    var viewModel = HomeViewModel()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    internal func setupUI() {
        view.backgroundColor = .white
        setNavigation()
        setupTableView()
        addSubviews()
        setConstraints()
        setupTableView()
        
        getPokemonData()
        viewModel.checkForNetwork { [weak self] status in
            guard let self = self else { return }
            if status == false {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: SBString.hs_alert_title, message: SBString.hs_alert_message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: SBString.hs_alert_action, style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    internal func setNavigation() {
        getUsernameFromKeychain()
        
        title = SBString.welcome_title + " " + viewModel.username
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: SBString.hs_favorite_button, style: .plain, target: self, action: #selector(favoritesButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .yellow
    }
    
    internal func addSubviews() {
        view.addSubview(tableView)
    }
    
    internal func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    internal func setupTableView() {
        setTableViewDelegates()
        tableView.backgroundColor = .tertiarySystemBackground
        tableView.rowHeight = 100.0
        tableView.register(PokemonCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.separatorStyle = .none
    }
    
    internal func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getUsernameFromKeychain() {
        viewModel.getUsernameFromKeychain()
    }
    
    @objc func favoritesButtonTapped() {
        navigationController?.pushViewController(FavoritesVC(), animated: true)
    }
}

extension HomeVC {
    private func getPokemonData() {
        viewModel.getPokemonData {
            self.tableView.reloadData()
        }
        tableView.reloadData()
    }
}

//MARK: - TableView delegate methods
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numberOfRows = viewModel.pokemons.results?.count {
            return numberOfRows
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as? PokemonCell else { return UITableViewCell() }
        cell.configureCell(viewModel.pokemons.results?[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PokemonDetailsVC()
        vc.viewModel.pokemonURL = viewModel.pokemons.results?[indexPath.row].url ?? ""
        vc.viewModel.pokemonName = viewModel.pokemons.results?[indexPath.row].name ?? "No Name"
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

