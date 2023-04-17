//
//  Publisher+.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import Combine

extension Publisher where Failure == Never {
    func singleOutput( with bag: inout Set<AnyCancellable>) async -> Output {
        return await withCheckedContinuation { continuation in
            sink(receiveValue: { value in
                continuation.resume(returning: value)
            }).store(in: &bag)
        }
    }
}
