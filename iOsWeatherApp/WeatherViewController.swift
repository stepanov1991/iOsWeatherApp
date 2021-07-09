//
//  ViewController.swift
//  iOsWeatherApp
//
//  Created by user on 08.07.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    lazy var headerView : HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var hoursWeatherCollectioView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectonView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectonView.translatesAutoresizingMaskIntoConstraints = false
        collectonView.register(HourWeatherCell.self, forCellWithReuseIdentifier: "HoursWeatherCell")
        collectonView.showsHorizontalScrollIndicator = false
        return collectonView
    }()
    
    lazy var dayWeatherTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(DayWeatherCell.self, forCellReuseIdentifier: "DayWeatherCell")
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    init(weatherData: WeatherData) {
        super.init(nibName: nil, bundle: nil)
        configureUI()
        getWeather(weatherData: weatherData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getWeather(weatherData: WeatherData) {
        headerView.cityLabel.text = weatherData.city
        headerView.descriptionLabel.text = weatherData.description
        headerView.tempLabel.text = "\(weatherData.temp)°"
        headerView.maxTempLabel.text = "В: \(weatherData.temp_max)°"
        headerView.minTempLabel.text = "Н: \(weatherData.temp_min)°"
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
            hoursWeatherCollectioView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 100),
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
            dayWeatherTableView.heightAnchor.constraint(equalToConstant: 200),
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
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HoursWeatherCell", for: indexPath) as! HourWeatherCell
        cell.backgroundColor = .clear
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate and UITableViewDataSource methods

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherCell", for: indexPath) as! DayWeatherCell
        cell.backgroundColor = .clear
        return cell
    }
    
    
}

