//
//  PokemonDetaillsViewModel.swift
//  NSoftPokemon
//
//  Created by OMERS on 9. 8. 2021..
//

import Foundation

class PokemonDetailsViewModel {
    var pokemonURL = ""
    var pokemonName = ""
    var arr = ""
    var pokemonTypes = [String]()
    var pokemon = PokemonDetails()
    
    internal func addFavoritesTapped() {
        debugPrint("Pokemon saved to Core Data")
        CoreDataService.shared.savePokemonCDData(name: pokemonName, imageUrl: pokemon.sprites?.front_default, baseExperience: pokemon.base_experience, weight: pokemon.weight, types: arr)
    }
    
    internal func getPokemonData(completion: @escaping ()->()) {
        Webservice.shared.getPokemonDetails(for: pokemonURL) { result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.pokemon = pokemon
                    completion()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


