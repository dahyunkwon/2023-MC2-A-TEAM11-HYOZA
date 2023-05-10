//
//  QuestionProperties.swift
//  Hyoza
//
//  Created by sei on 2023/05/10.
//

import Foundation

// MARK: - Codable

/// A struct encapsulating the properties of a Quake.
struct QuestionProperties: Decodable {

    // MARK: Codable
    
    private enum CodingKeys: String, CodingKey {
        case answer
        case answerTime
        case difficulty
        case timestamp
        case question
        case comment
    }
    
    let timestamp: Double       // 1539187727610
    let answerTime: Double       // 1539189727610
    let answer: String       // "답입니다1"
    var comment: String?      // "코멘트입니다1"
    let question: String       // "질문입니다1"
    let difficulty: Int       // 1
    let id: Int             // UUID
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let rawAnswer = try? values.decode(String.self, forKey: .answer)
        let rawAnswerTime = try? values.decode(Double.self, forKey: .answerTime)
        let rawDifficulty = try? values.decode(Int.self, forKey: .difficulty)
        let rawTimestamp = try? values.decode(Double.self, forKey: .timestamp)
        let rawQuestion = try? values.decode(String.self, forKey: .question)
        
        // Ignore earthquakes with missing data.
        guard let answer = rawAnswer,
              let answerTime = rawAnswerTime,
              let difficulty = rawDifficulty,
              let timestamp = rawTimestamp,
              let question = rawQuestion
        else {
//            return
            throw QuestionError.missingData
        }
        
        self.timestamp = timestamp
        self.answer = answer
        self.answerTime = answerTime
        self.difficulty = difficulty
        self.question = question
        self.id = Int(UUID().hashValue)
    }
    
    // The keys must have the same name as the attributes of the Quake entity.
    var dictionaryValue: [String: Any] {
        [
            "question": question,
            "answer": answer,
            "difficulty": difficulty,
            "answerTime": Date(timeIntervalSince1970: TimeInterval(answerTime) / 1000),
            "timestamp": Date(timeIntervalSince1970: TimeInterval(timestamp) / 1000),
            "id": Int64(id)
        ]
    }
}
