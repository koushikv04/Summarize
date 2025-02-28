//
//  StarlingService.swift
//  Summary
//
//  Created by Kouv on 25/02/2025.
//
import Foundation

struct StarlingService {
    
    private var accessToken = "Bearer STARLING ACCESS TOKEN"
    
    func fetchSummary()async throws -> String {
        var summary = "Hello Mike, hope you are doing great. We would like to provide a quick summary of your account and remind you of upcoming debits."
        let balance = try await fetchBalance()
        let categoriesSpending = try await fetchCategorySpending()
        let directDebits = try await fetchDirectDebits()
        summary += "Balance : £\(balance.amount.minorUnits)"
        summary += "The total spending of last month was £\(categoriesSpending.totalSpent). The top spendings are:"
        for category in categoriesSpending.breakdown {
            summary += "\(category.spendingCategory):£\(category.totalSpent)"
        }
        var debitCost = 50
        var debitDate = 4
        for debits in directDebits.mandates {
            summary += "\(debits.reference):£\(debitCost) on March \(debitDate)th 2025"
            debitCost += 40
            debitDate += 4
        }
        
    
        return summary
    }
    private func fetchBalance() async throws -> Balance {
        let url = URL(string: "https://api-sandbox.starlingbank.com/api/v2/accounts/<ACCOUNT UID>/balance")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        let (data,_) = try await URLSession.shared.data(for: urlRequest)
        let balance = try JSONDecoder().decode(Balance.self, from: data)
        return balance
    }
    
    private func fetchCategorySpending() async throws -> Spendings {
        let url = URL(string: "https://api-sandbox.starlingbank.com/api/v2/accounts/<ACCOUNT UID>/spending-insights/spending-category?year=2025&month=FEBRUARY")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        let (data,_) = try await URLSession.shared.data(for: urlRequest)
        let spendings = try JSONDecoder().decode(Spendings.self, from: data)
        return spendings
    }
    
    private func fetchDirectDebits() async throws -> DirectDebits {
        let url = URL(string: "https://api-sandbox.starlingbank.com/api/v2/direct-debit/mandates/account/<ACCOUNT UID>")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(accessToken, forHTTPHeaderField: "Authorization")
        let (data,_) = try await URLSession.shared.data(for: urlRequest)
        let directDebits = try JSONDecoder().decode(DirectDebits.self, from: data)
        return directDebits
    }
}
