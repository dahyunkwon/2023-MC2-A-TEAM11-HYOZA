//
//  Question+CoreDataClass.swift
//  Hyoza
//
//  Created by 최명근 on 2023/05/04.
//
//

import Foundation
import CoreData

@objc(Question)
public class Question: NSManagedObject {

    /// Updates a Quake instance with the values from a QuakeProperties.
    func update(from questionProperties: QuestionProperties) throws {
        let dictionary = questionProperties.dictionaryValue
        guard let newQuestion = dictionary["question"] as? String,
              let newAnswer = dictionary["answer"] as? String,
              let newDifficulty = dictionary["difficulty"] as? Int,
              let newAnswerTime = dictionary["answerTime"] as? Date,
              let newTimestamp = dictionary["timestamp"] as? Date,
              let newId = dictionary["id"] as? Int
        else {
            throw QuestionError.missingData
        }
        
        answer = newAnswer
        difficulty = Int32(newDifficulty)
        answerTime = newAnswerTime
        question = newQuestion
        id = Int64(newId)
        timestamp = newTimestamp
    }
}
