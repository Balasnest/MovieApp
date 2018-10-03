
//
//  URLSessionManager.swift
//  PlacesApp
//
//  Created by Sumit Ghosh on 28/09/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit

class URLSessionManager: NSObject {
    
    static let shared = URLSessionManager()
    
    //setting the URL session configuration
    private func defaultSessionConfiguration() -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        config.timeoutIntervalForResource = 60.0
        return config
    }
    
    //setting the session back configuration
    private func configureBackgroundSession(_ identifier: String) -> URLSessionConfiguration {
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: identifier)
        return sessionConfig
    }
    
    //creating session instance
    private func getSharedSession() -> URLSession {
        let configuration = self.defaultSessionConfiguration()
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:nil )
        return session
    }
   
    //MARK: GET Request
    func getRequest(with url:URL, completionHandler: @escaping(Data?, Error?) -> Void) -> Void {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        
        let sessionTask = URLSession.shared
        sessionTask.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completionHandler(nil, error)
                return
            }
            let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
            if (httpResponse.statusCode == 200) {
                completionHandler(data, nil)
            }
            else {
                completionHandler(nil, error)
            }
            }.resume()
        sessionTask.finishTasksAndInvalidate()
    }
}


extension URLSessionManager: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
    }
    
}
