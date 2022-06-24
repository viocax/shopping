//
//  Domain.OrderChecking.swift
//  Shpping
//
//  Created by Jie liang Huang on 2022/6/24.
//

import RxSwift

extension Domain {
    class OrderChecking {
    
    }
}

extension Domain.OrderChecking: OrderCheckingUseCase {
    func checkOut() -> Observable<Void> {
        return .empty()
    }
}
