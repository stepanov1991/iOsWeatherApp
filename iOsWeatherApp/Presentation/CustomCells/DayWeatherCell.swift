//
//  DayWeatherCell.swift
//  iOsWeatherApp
//
//  Created by user on 08.07.2021.
//

import UIKit

class DayWeatherCell: UITableViewCell {
    
    lazy var dayLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Понеділок"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var weatherImageIcon : UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "cloud.rain.fill")
        image.tintColor = .white
        return image
    }()
    
    lazy var rainSquareLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "50%"
        label.textColor = .blue
        label.alpha = 0.5
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    lazy var maxTempLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "29"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var minTempLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "15"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureUI() {
        setupDayLabel()
        setupWeatherImageIcon()
        setupRainSquareLabel()
        setupMinTempLabel()
        setupMaxTempLabel()
           }
    
    private func setupDayLabel() {
        contentView.addSubview(dayLabel)
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
        ])
    }
    
    private func setupWeatherImageIcon() {
        contentView.addSubview(weatherImageIcon)
        NSLayoutConstraint.activate([
            weatherImageIcon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            weatherImageIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            weatherImageIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func setupRainSquareLabel() {
        contentView.addSubview(rainSquareLabel)
        NSLayoutConstraint.activate([
            rainSquareLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            rainSquareLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            rainSquareLabel.leadingAnchor.constraint(equalTo: weatherImageIcon.trailingAnchor, constant: 5),
        ])
    }
    
    private func setupMinTempLabel() {
        contentView.addSubview(minTempLabel)
        NSLayoutConstraint.activate([
            minTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            minTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            minTempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }
    
    private func setupMaxTempLabel() {
        contentView.addSubview(maxTempLabel)
        NSLayoutConstraint.activate([
            maxTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            maxTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            maxTempLabel.trailingAnchor.constraint(equalTo: minTempLabel.leadingAnchor, constant: -10),
        ])
    }
    
}
