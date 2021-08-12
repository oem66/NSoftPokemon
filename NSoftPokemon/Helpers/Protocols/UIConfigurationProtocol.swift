//
//  UIConfigurationProtocol.swift
//  NSoftPokemon
//
//  Created by Omer Rahmanovic on 6/28/21.
//

import Foundation

@objc protocol UIConfigurationProtocol {
    func setupUI()
    func setNavigation()
    func addSubviews()
    func setConstraints()
    @objc optional func addButtonAction()
    @objc optional func setTableViewDelegates()
    @objc optional func setupTableView()
    @objc optional func checkForConnection() -> Bool
}
