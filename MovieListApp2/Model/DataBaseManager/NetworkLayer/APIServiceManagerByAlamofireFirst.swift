//
//  ExtensionAPIServiceManager.swift
//  MovieListApp2
//
//  Created by adham ragap on 11/08/2021.
//

import Foundation
import Alamofire
class ApiServiceManager{
    func fetchDataFromApiByAlamofire(complation: @escaping([ResultsData]?,String?) -> (Void)){
         let url = URL(string: "http://api.themoviedb.org/3/discover/movie?api_key=0bb6c7c539136cb79804f10c8df0f767")
           
        let request = AF.request(url as! URLConvertible,method: .get,encoding: JSONEncoding.default)
        
        request.responseJSON { (responserData) in
            if let data = responserData.data{
               let jsonDecoder = JSONDecoder()
                if let decodedObject = try? jsonDecoder.decode(Movie.self, from: data){
                    complation(decodedObject.results,nil)
                }
            }
            if let error = responserData.error{
                let stringError = error.localizedDescription
//                print(stringError)
                complation(nil,stringError)
            }
        }
        
        
        
        
        
        
    }
    
    
    
   
}
