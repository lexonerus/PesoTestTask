//
//  ResoApiCaller.swift
//  ResoTest
//
//  Created by Alex Krzywicki on 14.07.2022.
//

import Foundation


final class PesoApiCaller {
    static let shared = PesoApiCaller()
    weak var delegate: ResoApiCallerDelegate?
    
    private struct Constants {
        static let urlString = "https://lexone.ru/host/peso.JSON"
    }
    
    public func updateOfficesData(completion: @escaping (Result<[Office], Error>) -> Void) {
        guard let url = URL(string: Constants.urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode([Office].self, from: data)
                completion(.success(jsonResult))
            }
            catch {
                completion(.failure(error))
                self.delegate?.showAlertWithError(error: error)
            }
        }
        task.resume()
    }
    
}
