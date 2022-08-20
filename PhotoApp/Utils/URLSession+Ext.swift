//
//  URLSession+Ext.swift
//  MagicGathering
//
//  Created by Nguyễn Việt on 07/07/2022.
//

import Foundation

extension URLSession {
    func data(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation({ c in
            dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    c.resume(throwing: NetworkRequest.RequestError.error(message: error.localizedDescription))
                } else {
                    if let data = data, let response = response {
                        c.resume(returning: (data, response))
                    } else {
                        c.resume(throwing: NetworkRequest.RequestError.error(message: "No data"))
                    }
                }
            }.resume()
        })
    }
}
