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
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Test"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        return label
    }()
    
    var location:String?  {
        didSet {
            guard let location = location else { return }
            getWeatherForecastData(for:location)
        }
    }
    
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
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupTimeLabel() {
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
        ])
    }
    
    private func setupLocationLabel() {
        contentView.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: 5),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
        ])
    }
    
    private func getWeatherForecastData(for location:String) {
        WeatherRepository.forecast(city: location) { [weak self] weather, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
//                    let alert =  UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    self?.present(alert, animated: true, completion: nil)
                    // show error in UIAlertController
                } else if let weather = weather {
                    self?.locationLabel.text = location
                    self?.tempLabel.text = String(weather.tempC ?? 0) + "°"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let localtime = weather.localtime
                    let localtimeDate = dateFormatter.date(from: localtime ?? "")
                    dateFormatter.dateFormat = "HH:mm"
                    let time = dateFormatter.string(from: localtimeDate ?? Date())
                    self?.timeLabel.text = time ?? ""

                }
            }
        }
    }
}
