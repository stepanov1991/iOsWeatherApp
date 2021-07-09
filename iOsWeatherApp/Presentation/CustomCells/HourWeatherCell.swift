//
//  HoursWeatherCell.swift
//  iOsWeatherApp
//
//  Created by user on 08.07.2021.
//

import UIKit

class HourWeatherCell: UICollectionViewCell {
    
    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "19"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var weatherImageIcon : UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sun.min.fill")
        image.tintColor = .yellow
        return image
    }()
    
    lazy var tempLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.text = "25"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let topLineView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let bottomLineView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        setupWeatherImageIcon()
        setupTopLineView()
        setupTimeLabel()
        setupTempLabel()
        setupBottomLineView()
    }
    
    private func setupTopLineView() {
        contentView.addSubview(topLineView)
        NSLayoutConstraint.activate([
            topLineView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topLineView.heightAnchor.constraint(equalToConstant: 0.5),
            topLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    private func setupWeatherImageIcon() {
        contentView.addSubview(weatherImageIcon)
        NSLayoutConstraint.activate([
            weatherImageIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImageIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImageIcon.widthAnchor.constraint(equalToConstant: 30),
            weatherImageIcon.heightAnchor.constraint(equalToConstant: 30),

        ])
    }
    
    private func setupTimeLabel() {
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
          //  timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: weatherImageIcon.topAnchor, constant: -5)
        ])
    }
    
    private func setupTempLabel() {
        contentView.addSubview(tempLabel)
        NSLayoutConstraint.activate([
      //      tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tempLabel.topAnchor.constraint(equalTo: weatherImageIcon.bottomAnchor, constant: 5)

        ])
    }
    
    private func setupBottomLineView() {
        contentView.addSubview(bottomLineView)
        NSLayoutConstraint.activate([
            bottomLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 0.5),
            bottomLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
