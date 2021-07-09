//
//  WeatherSummaryCell.swift
//  iOsWeatherApp
//
//  Created by Dmitry Keller on 09.07.2021.
//

import UIKit

class WeatherSummaryCell: UITableViewCell {
    
    lazy var summaryLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Сьогодні наразі сонячно, температура пілніметься до 30, ввечері впаде до 17"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureUI() {
        setupTopLineView()
        setupSummaryLabel()
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
    
    private func setupSummaryLabel() {
        contentView.addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
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
