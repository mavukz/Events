//
//  EventsDataModel.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

struct EventsDataModel {
    
    var eventName: String
    
    enum CodingKeys: CodingKey {
        case eventName
    }
}

// MARK: - Decoder

extension EventsDataModel: Decodable {
    
    init(with decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        eventName = try container.decodeIfPresent(String.self, forKey: .eventName) ?? ""
    }
}

/*
 Optional(["Events": <__NSSingleObjectArrayI 0x6000010acb60>(
 {
     dateFrom = "2020-10-21T14:41:00";
     dateTo = "2020-10-22T14:41:00";
     hasCheckedOut = 1;
     id = "a93c26d4-76bf-4e48-a433-03f400b85f01";
     isCheckedIn = 0;
     location = "Lungi's B&B";
     media =     (
                 {
             eventId = "a93c26d4-76bf-4e48-a433-03f400b85f01";
             files = "<null>";
             getMediaUrl = "https://oldmutual-test.survey.co.za/EventsQA/Uploads/a.jpg";
             id = "aa80a066-434c-4a35-9ef7-0c3168d39235";
             url = "a.jpg";
         },
                 {
             eventId = "a93c26d4-76bf-4e48-a433-03f400b85f01";
             files = "<null>";
             getMediaUrl = "https://oldmutual-test.survey.co.za/EventsQA/Uploads/app image-02.png";
             id = "d14303fd-2e40-4ffa-b3b6-5fe8f17e5fa9";
             url = "app image-02.png";
         },
                 {
             eventId = "a93c26d4-76bf-4e48-a433-03f400b85f01";
             files = "<null>";
             getMediaUrl = "https://oldmutual-test.survey.co.za/EventsQA/Uploads/ENTERTOMORROWCheckInCode.pdf";
             id = "fc3218c2-8a49-4cf3-beee-dc1327c215f1";
             url = "ENTERTOMORROWCheckInCode.pdf";
         },
                 {
             eventId = "a93c26d4-76bf-4e48-a433-03f400b85f01";
             files = "<null>";
             getMediaUrl = "https://oldmutual-test.survey.co.za/EventsQA/Uploads/GGMxadf26e4f-5dd0-445b-9e5b-741150f6c4fb (2).pdf";
             id = "eeb7bbda-1620-480b-a123-1b1ec2dae6b3";
             url = "GGMxadf26e4f-5dd0-445b-9e5b-741150f6c4fb (2).pdf";
         },
                 {
             eventId = "a93c26d4-76bf-4e48-a433-03f400b85f01";
             files = "<null>";
             getMediaUrl = "https://oldmutual-test.survey.co.za/EventsQA/Uploads/OverallReportAllz4f7ca889-575f-4a6b-a979-80fd861db9b5.ppt";
             id = "eb131929-b38b-4b45-98da-c93ba5fa50b7";
             url = "OverallReportAllz4f7ca889-575f-4a6b-a979-80fd861db9b5.ppt";
         },
                 {
             eventId = "a93c26d4-76bf-4e48-a433-03f400b85f01";
             files = "<null>";
             getMediaUrl = "https://oldmutual-test.survey.co.za/EventsQA/Uploads/zzz.mp4";
             id = "4ec3e67f-7a98-47fd-8cb6-07255c24b1f6";
             url = "zzz.mp4";
         }
     );
     registrationStatus = 1;
     removalDate = "2020-10-23T14:41:00";
     status = 2;
     title = "Nqwelo yam";
 }
 )
 ])*/

