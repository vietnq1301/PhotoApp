//
//  APIService.swift
//  PhotoApp
//
//  Created by Nguyễn Việt on 20/08/2022.
//

import Foundation

struct NetworkConfiguration {
    // Applicatopn access key
    static let ACCESS_KEY = "e6oaH4VgFim--xoWhpDt5BMj2DYhuqiPxCqU2mEQZDs"
    
    // Application secret key
    static let SECRET_KEY = "j-P2y8ScLnefNLZeH_i1WxYXgiTCUUe7VPTGaCPOIOw"
    
    // The Unsplash API url.
    static let API_URL = "https://api.unsplash.com/"
}

struct Respone<T: Decodable>: Decodable {
    var total: Int
    var results: [T]
}


struct NetworkRequest {
    
    static let shared = NetworkRequest()
    
    enum RequestError: Error {
        case invalidUrl
        case noHTTPRespone
        case http(status: Int)
        case error(message: String)
        case invalidDecoder
        
        var localizedDescription: String {
            switch self {
            case .invalidUrl:
                return "Invalid URL"
            case .noHTTPRespone:
                return "Not a HTTPRespone"
            case .http(let status):
                return "HTTP error: \(status)"
            case .error(let msg):
                return "\(msg)"
            case .invalidDecoder:
                return "Invalid Decoder"
            }
        }
    }
    
    enum Path {
        case randomPhoto
        case listCollections
        case collectionInfo(id: Int)
        case collectionPhotos(id: Int)
        case reletedCollections(id: Int)
        case searchPhotos
        case searchCollections
        case searchUsers
        
        func path() -> String {
            switch self {
            case .randomPhoto:
                return "/photos/random"
            case .listCollections:
                return "collections"
            case .collectionInfo(let id):
                return "collections/\(id)"
            case .collectionPhotos(let id):
                return "collections/\(id)/photos"
            case .reletedCollections(let id):
                return "collections/\(id)/related"
            case .searchPhotos:
                return "search/photos"
            case .searchCollections:
                return "search/collections"
            case .searchUsers:
                return "search/users"
            }
        }
    }
    
    var timeoutInterval = 30.0
    var successCodes: CountableRange<Int> = 200..<299
    var failureCodes: CountableRange<Int> = 400..<499
    
    func urlComponents(path: String, queryItems: [URLQueryItem] = []) throws -> URLComponents {
        guard let url = URL(string: NetworkConfiguration.API_URL) else {
            throw RequestError.invalidUrl
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    func GET<T: Decodable>(request: URLRequest) async throws -> T {
        
        let (data, respone) = try await URLSession.shared.data(urlRequest: request)
        guard let httpRespone = respone as? HTTPURLResponse else {
            throw RequestError.noHTTPRespone
        }
        
        let statusCode = httpRespone.statusCode
        if successCodes.contains(statusCode) {
            do {
                let decodeData = try JSONDecoder().decode(T.self, from: data)
                return decodeData
            }catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            
            throw RequestError.invalidDecoder
            
            
            
        } else if failureCodes.contains(statusCode) {
            let data = data
            let responseBody = try JSONSerialization.jsonObject(with: data, options: [])
            debugPrint(responseBody)
            throw RequestError.http(status: statusCode)
            
        } else {
            // Server returned response with status code different than expected `successCodes`.
            let info = [
                NSLocalizedDescriptionKey: "Request failed with code \(statusCode)",
                NSLocalizedFailureReasonErrorKey: "Wrong handling logic, wrong endpoing mapping or backend bug."
            ]
            let error = NSError(domain: "NetworkService", code: 0, userInfo: info)
            throw error
        }
    }
    
    
    /// Get Random photo
    func getRandomPhoto() async throws -> UnsplashPhoto {
        let path = NetworkRequest.Path.randomPhoto.path()
        let components = try urlComponents(path: path)
        guard let url = components.url else {
            throw RequestError.invalidUrl
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
        urlRequest.allHTTPHeaderFields = ["Authorization":"Client-ID \(NetworkConfiguration.ACCESS_KEY)"]
        
        let photo: UnsplashPhoto = try await GET(request: urlRequest)
        return photo
    }
    
    
    
}



