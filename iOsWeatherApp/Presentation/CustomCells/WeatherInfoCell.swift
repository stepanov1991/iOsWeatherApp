//
//  WeatherInfoCell.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import UIKit

class WeatherInfoCell: UITableViewCell {
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var valueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let bottomLineView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureUI() {
        setuptitleLabel()
        setuptValueLabel()
        setupBottomLineView()
    }
    
    private func setuptitleLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            //            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setuptValueLabel() {
        contentView.addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 5),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupBottomLineView() {
        contentView.addSubview(bottomLineView)
        NSLayoutConstraint.activate([
            bottomLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 0.5),
            bottomLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bottomLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func load(for type: WeatherInfoType ) {
        titleLabel.text = type.title()
        valueLabel.text = type.value()
    }
}
