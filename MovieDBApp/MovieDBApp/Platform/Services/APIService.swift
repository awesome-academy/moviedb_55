//
//  APIService.swift
//  MovieDBApp
//
//  Created by Phong Le on 28/07/2021.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift

class APIService {
    static let shared = APIService()
    
    private init() {}
    
    func request<T: Mappable>(URL: String, responseType: T.Type) -> Observable<T> {
        guard
            let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let API_KEY = dict["API_KEY"] as? String
        else { fatalError() }
        
        let params = [
            "api_key": API_KEY
        ]
        
        return Observable.create { observer in
            AF.request(
                URL,
                method: .get,
                parameters: params,
                encoding: URLEncoding.default
            )
            .validate(statusCode: 200 ..< 300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    guard let object = Mapper<T>().map(JSONObject: data) else { return }
                    observer.onNext(object)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
