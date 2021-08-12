//
//  FavoritesViewModel.swift
//  NSoftPokemon
//
//  Created by OMERS on 5. 8. 2021..
//

import Foundation

class FavoritesViewModel {
    var pokemons = [PokemonCD]()
    
    internal func fetchFromCoreData() {
        CoreDataService.shared.fetchPokemonCDData { [weak self] pokemons in
            guard let self = self else { return }
            self.pokemons = pokemons
        }
    }
}
