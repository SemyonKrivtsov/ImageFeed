//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Семён Кривцов on 09.06.2024.
//

import Foundation

final class OAuth2Service {
    static let shared = OAuth2Service()
    private let urlSession = URLSession.shared
    
    private init() {}
    
    
    func fetchAuthToken(code: String, handler: @escaping (Result<String, Error>) -> Void) {
        guard let request = makeOAuthTokenRequest(code: code) else {
            print("fetchAuthToken: bad request")
            return
        }
        
        let dataTask = urlSession.data(for: request) { (result: Result<Data, any Error>) in
            switch result {
            case .success(let oAuthTokenResponse):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let data = try decoder.decode(OAuthTokenResponseBody.self, from: oAuthTokenResponse)
                    let token = data.accessToken
                    handler(.success(token))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Private methods
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard let baseURL = URL(string: "https://unsplash.com") else {
            print("Bad baseURL")
            return nil
        }
        guard let url = URL(
            string: "/oauth/token"
            + "?client_id=\(Constants.accessKey)"
            + "&&client_secret=\(Constants.secretKey)"
            + "&&redirect_uri=\(Constants.redirectURI)"
            + "&&code=\(code)"
            + "&&grant_type=authorization_code",
            relativeTo: baseURL
        ) else {
            print("Bad main url")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
}
