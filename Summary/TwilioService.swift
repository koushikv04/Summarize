//
//  TwilioService.swift
//  Summary
//
//  Created by Kouv on 25/02/2025.
//
import Foundation

struct TwilioService {
    
    func makeTheCallService(content:String) {
        var urlRequest = URLRequest(url: URL(string: "https://api.twilio.com/2010-04-01/Accounts/<ACCOUNT SID>/Calls.json")!)
        urlRequest.httpMethod = "POST"
        let authData = ("ACCOUNT SID:AUTH TOKEN").data(using: .utf8)!.base64EncodedString()
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = "To=<TO_NUMBER_GOES_HERE>&From=<FROM_NUMBER_GOES_HERE>&Twiml=<Response><Say>\(content)</Say></Response>".data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest) { _, response, error in
            if let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode != 200 {
                print("Error calling user \(error?.localizedDescription ?? "Twilio error")")
            }
        }.resume()
            
    }
}
