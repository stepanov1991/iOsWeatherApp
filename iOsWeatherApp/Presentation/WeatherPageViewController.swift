//
//  WeatherPageViewController.swift
//  iOsWeatherApp
//
//  Created by user on 08.07.2021.
//

import UIKit

class WeatherPageViewController: UIPageViewController {
    
    var locationArray = LocationManager.locationArray
    
    lazy var arrayWeatherViewController = calculateWeatherViewControllers()
        
    lazy var showVCListButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "list.dash"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(showVCListButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        configureUI()
        self.delegate = self
        self.dataSource = self
        setViewControllers([arrayWeatherViewController[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .locationArrayDidChange, object: nil)
    }
    
    @objc
    private func reload() {
        arrayWeatherViewController = calculateWeatherViewControllers()
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
    
    private func calculateWeatherViewControllers() -> [WeatherViewController] {
        var weatherVC = [WeatherViewController]()
        for location in locationArray {
            let vc      = WeatherViewController()
            vc.location = location
            weatherVC.append(vc)
        }
        return weatherVC
    }
    
    @objc func showVCListButtonPressed() {
        let vc = LocationsViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        print("showVCListButtonPressed")
    }
    
    @objc func onDidGetLocation(_ notification: Notification){
        
    }
}


extension Notification.Name {
    static let getLocation = Notification.Name("didgetLocation")
}

// MARK: - UIPageViewControllerDelegate and UIPageViewControllerDataSource methods

extension WeatherPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
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
            if index < locationArray.count - 1 {
                return arrayWeatherViewController[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return locationArray.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
