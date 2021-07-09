//
//  WeatherPageViewController.swift
//  iOsWeatherApp
//
//  Created by user on 08.07.2021.
//

import UIKit

class WeatherPageViewController: UIPageViewController {
    
    var weatherArray = [WeatherData]()
    
    lazy var arrayWeatherViewController: [WeatherViewController] = {
        var weatherVC = [WeatherViewController]()
        for weather in weatherArray {
            weatherVC.append(WeatherViewController(weatherData: weather))
        }
        return weatherVC
    }()

    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = .lightGray
        fethcWeatherData()
        self.delegate = self
        self.dataSource = self
        setViewControllers([arrayWeatherViewController[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fethcWeatherData() {
        let weather0 = WeatherData(city: "Хмельницький", description: "сонячно", temp: 28 , temp_min: 18, temp_max: 30)
        let weather1 = WeatherData(city: "Львів", description: "дощ", temp: 25 , temp_min: 15, temp_max: 28)
        let weather2 = WeatherData(city: "Київ", description: "хмарне небо", temp: 27 , temp_min: 20, temp_max: 28)
        weatherArray.append(weather0)
        weatherArray.append(weather1)
        weatherArray.append(weather2)
    }
}

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
