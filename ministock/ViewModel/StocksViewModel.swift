//
//  DividendViewModel.swift
//  ministock
//
//  Created by 윤지용 on 2022/02/28.
//

import UIKit

class StocksViewModel{
    let service = Service()
    
    var reloadTableView: () -> Void = {}
    var stocksModel = [Model]() {
        didSet {
            reloadTableView()
        }
    }
    func getStocks(){
        service.entityToModel { [weak self] model in
            self?.stocksModel = model
        }
    }
    func getCellViewModel(at indexPath: IndexPath) -> Model {
        
        return stocksModel[indexPath.row]
    }
    
}
