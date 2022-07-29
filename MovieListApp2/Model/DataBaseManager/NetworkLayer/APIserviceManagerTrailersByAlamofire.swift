//
//  APIserviceManagerTrailersByAlamofire.swift
//  MovieListApp2
//
//  Created by adham ragap on 13/08/2021.
//

import Foundation
import Alamofire
class  APIserviceManagerTrailersByAlamofire {
    func fetchDataFortrailers(id: Int?, complation:@escaping([Results]?,String?) -> Void) {
        
        let url = "http://api.themoviedb.org/3/movie/\(id ?? 0)/videos?api_key=0bb6c7c539136cb79804f10c8df0f767"
        
        let request = AF.request(url, method: .get,encoding: JSONEncoding.default)
        
        request.responseJSON { (responseData) in
            if let data = responseData.data{
                let jsondecoder = JSONDecoder()
                if let decodeObj = try? jsondecoder.decode(Json4Swift_Base.self, from: data){
                   // print(decodeObj)
                    complation(decodeObj.results,nil)
                }
            }
            if let error = responseData.error{
                let stringEror = error.localizedDescription
//                print(stringEror)
                complation(nil,stringEror)
            }
        }
    }
}
