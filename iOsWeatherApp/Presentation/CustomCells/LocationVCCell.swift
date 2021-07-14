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
    
    private func getWeatherForecastData(for location:String) {
        WeatherRepository.forecast(city: location) { [weak self] weather, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    // show error in UIAlertController
                } else if let weather = weather {
//                    let currentDate = Date()
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "yyyy-MM-dd"
//                    let currentDateString = dateFormatter.string(from: currentDate)
//                    self?.headerView.cityLabel.text = weather.name
//                    self?.headerView.tempLabel.text = "\(weather.tempC ?? 0)°"
//                    self?.headerView.descriptionLabel.text = weather.conditionText
//                    self?.currentDay = weather.forecastDay?.first(where: { ($0.date ?? "") == currentDateString })
//                    self?.headerView.maxTempLabel.text = "\(self?.currentDay?.day?.maxTempC ?? 0)°"
//                    self?.headerView.minTempLabel.text = "\(self?.currentDay?.day?.minTempC ?? 0)°"
//                    self?.hourWeather = self?.currentDay?.hour?.filter({ (hours: Hour) -> Bool in
//                        let timeString = hours.time
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//                        let timeDate = dateFormatter.date(from: timeString ?? "")
//                        let currentDate = Date()
//                        return timeDate ?? Date() >= currentDate
//                    })
//                    self?.forecastDayArray = weather.forecastDay
//                    self?.weatherArray = weather.toWeatherInfoArray()
//                    self?.hoursWeatherCollectioView.reloadData()
//                    self?.dayWeatherTableView.reloadData()
                }
            }
        }
    }
}
