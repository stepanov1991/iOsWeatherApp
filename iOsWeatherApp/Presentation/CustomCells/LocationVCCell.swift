//
//  TableViewCell.swift
//  iOsWeatherApp
//
//  Created by user on 14.07.2021.
//

import UIKit

class LocationVCCell: UITableViewCell {
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .white
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.backgroundColor = .blue
        setupTempLabel()
        setupTimeLabel()
        setupLocationLabel()
    }

    private func setupTempLabel() {
        contentView.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupTimeLabel() {
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
        ])
    }
    
    private func setupLocationLabel() {
        contentView.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: 5),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
        ])
    }
}
