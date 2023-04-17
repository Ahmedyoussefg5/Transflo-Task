//
//  ForecastRequest.swift
//  Transflo Task
//
//  Created by Youssef on 17/04/2023.
//

import Foundation

class ForecastRequest: RequestMaker {
    @GET<ForecastResponse>(url: .path(Urls.forecast), encoding: .url)
    var network: any Network<ForecastResponse>
}
