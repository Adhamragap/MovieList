//
//  APIserviceManagerReviewesByAlamofire.swift
//  MovieListApp2
//
//  Created by adham ragap on 15/08/2021.
//

import Foundation
import Alamofire
class APIserviceManagerReviewesByAlamofire{
    func fetchDataForReviews(id:Int?,complation :@escaping([ResultsReview]?,String?) -> Void){
        
let url = "http://api.themoviedb.org/3/movie/\(id ?? 0)/reviews?api_key=0bb6c7c539136cb79804f10c8df0f767"
        let request = AF.request(url, method: .get,encoding: JSONEncoding.default)
        request.responseJSON { (responseData) in
            if let data = responseData.data{
            let jsondecoder = JSONDecoder()
                if let decodedObject = try? jsondecoder.decode(LastRieview.self, from: data){
//                    print(decodedObject.results)
                    complation(decodedObject.results,nil)
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
