//
//  ViewController.swift
//  iOsWeatherApp
//
//  Created by user on 08.07.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var weatherData: ForecastData?
    var currentDay : ForecastDay?
    var hourWeather: [Hour]?
    var forecastDayArray: [ForecastDay]?
    var weatherArray: [WeatherInfoType]?
    var locationManage = LocationManager()
    var location:String? {
        didSet {
            guard let location = location else { return }
            getWeatherForecastData(for:location)
        }
    }
    
    lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var hoursWeatherCollectioView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectonView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectonView.translatesAutoresizingMaskIntoConstraints = false
        collectonView.register(HourWeatherCell.self, forCellWithReuseIdentifier: "HoursWeatherCell")
        collectonView.showsHorizontalScrollIndicator = false
        return collectonView
    }()
    
    lazy var dayWeatherTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(DayWeatherCell.self, forCellReuseIdentifier:     "DayWeatherCell")
        tableView.register(WeatherSummaryCell.self, forCellReuseIdentifier: "WeatherSummaryCell")
        tableView.register(WeatherInfoCell.self, forCellReuseIdentifier:    "WeatherInfoCell")
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func getWeatherForecastData(for location:String) {
        WeatherRepository.forecast(city: location) { [weak self] weather, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    // show error in UIAlertController
                } else if let weather = weather {
                    let currentDate = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let currentDateString = dateFormatter.string(from: currentDate)
                    self?.headerView.cityLabel.text = weather.name
                    self?.headerView.tempLabel.text = "\(weather.tempC ?? 0)°"
                    self?.headerView.descriptionLabel.text = weather.conditionText
                    self?.currentDay = weather.forecastDay?.first(where: { ($0.date ?? "") == currentDateString })
                    self?.headerView.maxTempLabel.text = "\(self?.currentDay?.day?.maxTempC ?? 0)°"
                    self?.headerView.minTempLabel.text = "\(self?.currentDay?.day?.minTempC ?? 0)°"
                    self?.hourWeather = self?.currentDay?.hour?.filter({ (hours: Hour) -> Bool in
                        let timeString = hours.time
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                        let timeDate = dateFormatter.date(from: timeString ?? "")
                        let currentDate = Date()
                        return timeDate ?? Date() >= currentDate
                    })
                    self?.forecastDayArray = weather.forecastDay
                    self?.weatherArray = weather.toWeatherInfoArray()
                    self?.hoursWeatherCollectioView.reloadData()
                    self?.dayWeatherTableView.reloadData()
                }
            }
            
        }
    }
    
    private func configureUI() {
        setupHeaderView()
        setupHoursWeatherCollectioView()
        setupDayWeatherTableView()
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupHoursWeatherCollectioView() {
        view.addSubview(hoursWeatherCollectioView)
        hoursWeatherCollectioView.dataSource = self
        hoursWeatherCollectioView.delegate = self
        hoursWeatherCollectioView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            hoursWeatherCollectioView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50),
            hoursWeatherCollectioView.heightAnchor.constraint(equalTo: hoursWeatherCollectioView.widthAnchor, multiplier: 0.25),
            hoursWeatherCollectioView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hoursWeatherCollectioView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupDayWeatherTableView() {
        view.addSubview(dayWeatherTableView)
        dayWeatherTableView.backgroundColor = .clear
        dayWeatherTableView.delegate = self
        dayWeatherTableView.dataSource = self
        NSLayoutConstraint.activate([
            dayWeatherTableView.topAnchor.constraint(equalTo: hoursWeatherCollectioView.bottomAnchor),
            dayWeatherTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dayWeatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dayWeatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - UICollectionViewDataSource and UICollectionViewDelegateFlowLayout methods

extension WeatherViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/6, height: collectionView.frame.width/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourWeather?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoursWeatherCell", for: indexPath) as! HourWeatherCell
        cell.backgroundColor = .clear
        let hour = hourWeather?[indexPath.item]
        cell.fethHoursWeather(weather: hour)
        return cell
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource methods
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0      { return forecastDayArray?.count ?? 0  }
        else if section == 1 { return 1  } // Summary
        else                 { return weatherArray?.count ?? 0 } // [WeatherInfoType].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as! DayWeatherCell
            cell.backgroundColor = .clear
            cell.fetchDaysWeathers(day: forecastDayArray?[indexPath.row].day)
            if let forecastDay = forecastDayArray?[indexPath.row] {
                cell.getdayofWeak(forecastDay: forecastDay )
            }
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherSummaryCell", for: indexPath) as! WeatherSummaryCell
            cell.backgroundColor = .clear
            cell.getSummaryof(day: forecastDayArray?[indexPath.row].day)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInfoCell", for: indexPath) as! WeatherInfoCell
            cell.backgroundColor = .clear
            if let weather = weatherArray?[indexPath.row] {
                cell.load(for: weather)
            }
            return cell
        }
    }
}

