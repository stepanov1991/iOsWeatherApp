//
//  HeaderView.swift
//  iOsWeatherApp
//
//  Created by user on 08.07.2021.
//

import UIKit

class HeaderView: UIView {
    
    lazy var cityLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var tempLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 70)
        return label
    }()
    
    lazy var maxTempLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var minTempLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        setupCityLabel()
        setupDescriptionLabel()
        setupTempLabel()
        setupMaxTempLabel()
        setupMinTempLabel()
    }
    
    
    private func setupCityLabel() {
        self.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func setupDescriptionLabel() {
        self.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func setupTempLabel() {
        self.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            tempLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func setupMaxTempLabel() {
        self.addSubview(maxTempLabel)
        NSLayoutConstraint.activate([
            maxTempLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5),
            maxTempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            maxTempLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -5),
        ])
    }
    
    private func setupMinTempLabel() {
        self.addSubview(minTempLabel)
        NSLayoutConstraint.activate([
            minTempLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5),
            minTempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            minTempLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 5),
        ])
    }
    
}
