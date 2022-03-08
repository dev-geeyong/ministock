//
//  Protocol.swift
//  ministock
//
//  Created by 윤지용 on 2022/03/08.
//

import UIKit

protocol PushNavgationDelegate: AnyObject { // 위임해줄 기능
    func pushButtonTapped()
    
}

protocol ShowBottomSheetDelegate: AnyObject {
    func pushButtonTapped2()
}
