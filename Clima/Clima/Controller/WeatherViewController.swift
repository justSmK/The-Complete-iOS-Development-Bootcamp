//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation.CLLocationManager

class WeatherViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: Constants.background)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .trailing
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var geoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: Constants.geoSF), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(locationPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constants.search
        textField.borderStyle = .roundedRect
        textField.textAlignment = .right
        textField.font = .systemFont(ofSize: 25)
        textField.textColor = .label
        textField.tintColor = .label
        textField.backgroundColor = .systemFill
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: Constants.searchSF), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: Constants.conditionSF)
        imageView.image = image
        imageView.tintColor = UIColor(named: Constants.weatherColor)
        return imageView
    }()
    
    private lazy var temperatureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .label
        label.font = .systemFont(ofSize: 80, weight: .black)
        return label
    }()
    
    private lazy var temperatureTypeLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .label
        label.font = .systemFont(ofSize: 100, weight: .light)
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .label
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    private lazy var emptyView = UIView()
    
    private var spinnerActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    // MARK: - Provate Properties
    
    private var weatherManager = WeatherManager()
    private let locationManager = CLLocationManager()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setDelegates()
        setupLocationSettings()
    }
    
    // MARK: - Private Methods
    
    private func setDelegates() {
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
    }
    
    private func setupLocationSettings() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    // MARK: - Actions
    
    @objc
    private func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    @objc
    private func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    // MARK: - Setup Views

    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(headerStackView)
        
        headerStackView.addArrangedSubview(geoButton)
        headerStackView.addArrangedSubview(searchTextField)
        headerStackView.addArrangedSubview(searchButton)
        
        mainStackView.addArrangedSubview(conditionImageView)
        mainStackView.addArrangedSubview(temperatureStackView)
        
        temperatureStackView.addArrangedSubview(temperatureLabel)
        temperatureStackView.addArrangedSubview(temperatureTypeLabel)
        
        mainStackView.addArrangedSubview(cityLabel)
        
        mainStackView.addArrangedSubview(emptyView)
        
        
        view.addSubview(spinnerActivityIndicatorView)
        spinnerActivityIndicatorView.center = view.center
        isWorkActivityIndicator(isAnimated: true, indicator: spinnerActivityIndicatorView)
    }

    private func isWorkActivityIndicator(isAnimated: Bool, indicator: UIActivityIndicatorView) {
        if isAnimated {
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
            indicator.hidesWhenStopped = true
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        weatherManager.fetchWeather(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.temperatureTypeLabel.text = Constants.celsius
            self.conditionImageView.image = UIImage(systemName: weather.getConditionName)
            self.cityLabel.text = weather.cityName
            
            self.isWorkActivityIndicator(isAnimated: false, indicator: self.spinnerActivityIndicatorView)
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.isWorkActivityIndicator(isAnimated: false, indicator: self.spinnerActivityIndicatorView)
            let alertController = UIAlertController(title: "Error", message: "Enter the full name of the city", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
        debugPrint(error)
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        if !text.isEmpty {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        searchTextField.text?.removeAll(where: { character in
            character == " "
        })
        if let city = searchTextField.text {
            isWorkActivityIndicator(isAnimated: true, indicator: spinnerActivityIndicatorView)
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = String()
    }
}

// MARK: - Setup Constraints

private extension WeatherViewController {
    func setupConstraints() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        mainStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(24)
        }

        headerStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        geoButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        conditionImageView.snp.makeConstraints { make in
            make.width.height.equalTo(120)
        }
    }
}
