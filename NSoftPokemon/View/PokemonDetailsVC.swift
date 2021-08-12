//
//  PokemonDetailsVC.swift
//  NSoftPokemon
//
//  Created by Omer Rahmanovic on 6/29/21.
//

import UIKit
import SDWebImage

class PokemonDetailsVC: UIViewController, UIConfigurationProtocol {

    lazy var detailsContainer = UIView()
    lazy var pokemonImage = SDAnimatedImageView()
    lazy var divider = UIView.newDivider()
    lazy var baseExperienceLabel = UILabel.newLabel(SBString.pds_base_experience, false, .black, 14)
    lazy var weightLabel = UILabel.newLabel(SBString.pds_weight, false, .black, 14)
    lazy var typesLabel = UILabel.newLabel(SBString.pds_types, false, .black, 14)
    lazy var addFavoritesButton = UIButton.newButton(SBString.pds_button_title, UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0))
    
    var viewModel = PokemonDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    internal func setupUI() {
        setNavigation()
        addSubviews()
        setConstraints()
        
        viewModel.getPokemonData {
            self.setUIElementsValue()
        }
    }
    
    internal func setNavigation() {
        title = viewModel.pokemonName
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: SBString.back_button, style: .plain, target: nil, action: nil)
        view.backgroundColor = .tertiarySystemBackground
    }
    
    internal func addSubviews() {
        view.addSubview(detailsContainer)
        [pokemonImage, divider, baseExperienceLabel, weightLabel, typesLabel, addFavoritesButton].forEach { detailsContainer.addSubview($0) }
        [detailsContainer, pokemonImage].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    internal func setConstraints() {
        addFavoritesButton.setTitleColor(.black, for: .normal)
        
        detailsContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        pokemonImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(120)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(pokemonImage.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        baseExperienceLabel.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        weightLabel.snp.makeConstraints {
            $0.top.equalTo(baseExperienceLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        typesLabel.snp.makeConstraints {
            $0.top.equalTo(weightLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        addFavoritesButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-80)
            $0.leading.trailing.equalToSuperview().inset(60)
            $0.height.equalTo(50)
        }        
        addButtonAction()
    }
    
    internal func addButtonAction() {
        addFavoritesButton.addTarget(self, action: #selector(addToFavoritesTapped), for: .touchUpInside)
    }
    
    private func setUIElementsValue() {
        if let imageUrl = viewModel.pokemon.sprites?.front_default,
           let baseExperience = viewModel.pokemon.base_experience,
           let weight = viewModel.pokemon.weight {
            self.pokemonImage.sd_setImage(with: URL(string: imageUrl))
            self.baseExperienceLabel.text = "\(SBString.pds_base_experience) \(baseExperience)"
            self.weightLabel.text = "\(SBString.pds_weight) \(weight)"
        }
        viewModel.pokemon.types?.forEach({ type in
            viewModel.pokemonTypes.append((type.type?.name?.uppercased())!)
        })
        viewModel.arr = viewModel.pokemonTypes.map { (string) -> String in
            return String(string)
        }.joined(separator: "/")
        
        self.typesLabel.text = "\(SBString.pds_types) \(viewModel.arr)"
    }
    
    @objc func addToFavoritesTapped() {
        viewModel.addFavoritesTapped()
        showCustomAlert(title: SBString.alert_title_success, message: (viewModel.pokemonName) + SBString.alert_message_added_fav, actionTitle: SBString.alert_action_ok)
    }
    
    private func showCustomAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
