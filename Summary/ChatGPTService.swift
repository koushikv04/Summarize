//
//  ChatGPTService.swift
//  Summary
//
//  Created by Kouv on 25/02/2025.
//
import Foundation
import Combine

struct ChatGPTService {
    
    func getSummary(content:String) -> AnyPublisher<ChatResponse,Error> {
        let system = ["role":"system","content":"You will be provided with banking information. You need to create a nice polite paragraph summarising all information to the customer.Finish with any assistance required contact us and wish you a awesome day. Remove yours truly in the end"]
        let user = ["role":"user","content":content]
        let params:[String:Any] = ["model":"gpt-4o-mini","messages":[system,user],"store":true]
        var urlRequest = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer <ACCESS TOKEN>", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
       return  URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: ChatResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
}
