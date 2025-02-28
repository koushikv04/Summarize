//
//  SummaryViewModel.swift
//  Summary
//
//  Created by Kouv on 23/02/2025.
//

import Foundation
import Combine

struct ChatResponse:Decodable {
    var choices:[Choice]
}

struct Choice:Decodable {
    var index:Int
    var message: Message
}

struct Message:Decodable {
    var role:String
    var content:String
}

struct Balance:Decodable {
    var amount:Amount
}

struct Amount:Decodable {
    var currency:String
    var minorUnits:Int
}

struct Spendings:Decodable {
    var totalSpent:Double
    var breakdown:[Category]
}

struct Category:Decodable {
    var spendingCategory: String
    var totalSpent: Double
}

struct DirectDebits:Decodable {
    var mandates:[Mandate]
}

struct Mandate:Decodable {
    var reference:String
    var status:String
}

class SummaryViewModel:ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private var twilioService = TwilioService()
    private var chatgptService = ChatGPTService()
    private var starlingService = StarlingService()
    
    @Published var summaryText = "Hello there 😃, Get a summary of your Starling bank account. Click on the button below to fetch your starling bank details."

    
    func getSummary(completion: @escaping (Bool) -> Void) async throws {
        let content =  try await starlingService.fetchSummary()
        chatgptService.getSummary(content: content)
            .receive(on: DispatchQueue.main)
            .sink { response in
                switch response {
                case .failure(let error):
                    print("Error getting response from chatgpt service \(error.localizedDescription)")
                case .finished:
                    print("Successfully fetched chatgpt response")
                }
                completion(true)
            } receiveValue: { chatResponse in
                if let choice = chatResponse.choices.first {
                    self.summaryText = choice.message.content
                } else {
                    print("Failed to fetch chat gpt response")
                }
            }
            .store(in: &cancellables)
    }
    
    func callWithSummary() {
        twilioService.makeTheCallService(content: summaryText)
    }
}
