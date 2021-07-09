//
//  WeatherPageViewController.swift
//  iOsWeatherApp
//
//  Created by user on 08.07.2021.
//

import UIKit

class WeatherPageViewController: UIPageViewController {
    
    var weatherArray = [WeatherModel]()
    
    lazy var arrayWeatherViewController: [WeatherViewController] = {
        var weatherVC = [WeatherViewController]()
        for weather in weatherArray {
            weatherVC.append(WeatherViewController(weatherData: weather))
        }
        return weatherVC
    }()
    
    lazy var showVCListButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "list.dash"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(showVCListButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()

    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        configureUI()
        fethcWeatherData()
        self.delegate = self
        self.dataSource = self
        setViewControllers([arrayWeatherViewController[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.view.backgroundColor = .lightGray
        setupShowVCListButton()
    }
    
    private func setupShowVCListButton() {
        view.addSubview(showVCListButton)
        NSLayoutConstraint.activate([
            showVCListButton.heightAnchor.constraint(equalToConstant: 20),
            showVCListButton.widthAnchor.constraint(equalToConstant: 20),
            showVCListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            showVCListButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fethcWeatherData() {
        let weather0 = WeatherModel(city: "Хмельницький", description: "сонячно", temp: 28 , temp_min: 18, temp_max: 30)
        let weather1 = WeatherModel(city: "Львів", description: "дощ", temp: 25 , temp_min: 15, temp_max: 28)
        let weather2 = WeatherModel(city: "Київ", description: "хмарне небо", temp: 27 , temp_min: 20, temp_max: 28)
        weatherArray.append(weather0)
        weatherArray.append(weather1)
        weatherArray.append(weather2)
    }
    
    @objc func showVCListButtonPressed() {
        print("showVCListButtonPressed")
    }
}

// MARK: - UIPageViewControllerDelegate and UIPageViewControllerDataSource methods

extension WeatherPageViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? WeatherViewController else {return nil}
        if let index = arrayWeatherViewController.firstIndex(of: viewController) {
            if index > 0 {
                return arrayWeatherViewController[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? WeatherViewController else {return nil}
        if let index = arrayWeatherViewController.firstIndex(of: viewController) {
            if index < weatherArray.count - 1 {
                return arrayWeatherViewController[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return weatherArray.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
