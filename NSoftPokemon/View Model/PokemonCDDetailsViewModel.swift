//
//  PokemonCDDetailsViewModel.swift
//  NSoftPokemon
//
//  Created by OMERS on 9. 8. 2021..
//

import Foundation

class PokemonCDDetailsViewModel {
    var pokemonName = ""
    var pokemon = PokemonCD()
    
    internal func removeFromFavoritesTapped() {
        let pokemon = pokemon
        PersistanceService.context.delete(pokemon)
        PersistanceService.saveContext()
    }
}
