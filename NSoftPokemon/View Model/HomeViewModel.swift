//
//  HomeViewModel.swift
//  NSoftPokemon
//
//  Created by OMERS on 4. 8. 2021..
//

import Foundation
import Network

class HomeViewModel {
    var username = ""
    let monitor = NWPathMonitor()
    var pokemons = PokemonsContainer()
    
    internal func checkForNetwork(completion: @escaping (Bool)->()) {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                debugPrint("Device is connected to the internet!")
                completion(true)
            } else {
                debugPrint("Device is not connected to the internet!")
                completion(false)
            }
            debugPrint("Connection is using Cellular data: \(path.isExpensive)")
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    internal func getPokemonData(completion: @escaping ()->()) {
        Webservice.shared.getPokemons { result in
            switch result {
            case .success(let pokemons):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.pokemons = pokemons
                    completion()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    internal func getUsernameFromKeychain() {
        if let username = KeychainWrapper.standard.string(forKey: "UsernameKeychain") {
            self.username = username
        }
    }
}
