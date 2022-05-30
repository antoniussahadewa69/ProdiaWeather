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
                    if let dataError = dataResponse.data {
                        do {
                            let apiErrorDto = try JSONDecoder().decode(ApiErrorDto.self, from: dataError)
                            errors(apiErrorDto)
                        } catch {
                            errors(ApiErrorDto(status: -1, message: error.localizedDescription))
                        }
                    } else {
                        errors(ApiErrorDto(status: -1, message: error.localizedDescription))
                    }
                    break
                case .success(let data):
                    complete(data)
                    break
            }
        }
        return request
    }
}
