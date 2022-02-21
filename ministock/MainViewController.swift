//
//  ViewController.swift
//  ministock
//
//  Created by IT on 2022/02/15.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Propertie
   

    private let slideShowView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .blue
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    let myFavoriteView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .blue
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    let stocksView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .blue
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    let dividendStocksView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .systemBlue
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    let exchangeRateView: UIView = {
       let uv = UIView()
        uv.backgroundColor = .systemRed
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
  
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupViews()
        
    }
    //MARK: - Actions
    //MARK: - Helpers
    func setupViews(){
        contentView.addSubview(slideShowView)
        slideShowView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        slideShowView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        slideShowView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        slideShowView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        contentView.addSubview(myFavoriteView)
        myFavoriteView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        myFavoriteView.topAnchor.constraint(equalTo: slideShowView.bottomAnchor, constant: 15).isActive = true
        myFavoriteView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        myFavoriteView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        contentView.addSubview(stocksView)
        stocksView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stocksView.topAnchor.constraint(equalTo: myFavoriteView.bottomAnchor, constant: 15).isActive = true
        stocksView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        stocksView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
        contentView.addSubview(dividendStocksView)
        dividendStocksView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        dividendStocksView.topAnchor.constraint(equalTo: stocksView.bottomAnchor, constant: 0).isActive = true
        dividendStocksView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        dividendStocksView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        contentView.addSubview(exchangeRateView)
        exchangeRateView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        exchangeRateView.topAnchor.constraint(equalTo: dividendStocksView.bottomAnchor, constant: 15).isActive = true
        exchangeRateView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        exchangeRateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        exchangeRateView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.backgroundColor = .yellow
        contentView.backgroundColor = .green
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
}

