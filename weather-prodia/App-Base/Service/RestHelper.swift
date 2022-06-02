//
//  RestHelper.swift
//  weather-prodia
//
//  Created by Krisna on 30/05/22.
//

import Foundation
import Alamofire

class RestHelper{
    
    func getHeader() -> HTTPHeaders {
        return [
           "Content-Type": "application/json"
       ]
    }
    
    func get<T : Decodable>(url: String,
                             responseType: T.Type,
                             complete: @escaping((T) -> Void),
                             errors: @escaping((ApiErrorDto) -> Void) ) -> DataRequest  {
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:nil)
            .validate(statusCode: 200...300)
            .responseDecodable(of: responseType) { dataResponse in
                switch dataResponse.result {
                case .failure(let error):
                    errors(ApiErrorDto(status: error.responseCode, message: error.failureReason))
                    break
                case .success(let data):
                    complete(data)
                    break
            }
        }
        return request
    }
}
