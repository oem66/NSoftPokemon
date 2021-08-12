//
//  PokemonCell.swift
//  NSoftPokemon
//
//  Created by Omer Rahmanovic on 6/29/21.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    lazy var cellContainer = UIView()
    lazy var titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        [cellContainer, titleLabel].forEach { addSubview($0) }
        
        configureUI()
        setUIConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PokemonCell {
    internal func configureCell(_ title: String?) {
        if let title = title {
            self.titleLabel.text = title
        }
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        cellContainer.backgroundColor = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        cellContainer.layer.cornerRadius = 10.0
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setUIConstraints() {
        [cellContainer, titleLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        cellContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
