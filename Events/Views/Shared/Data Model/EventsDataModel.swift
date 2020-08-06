//
//  EventsDataModel.swift
//  Events
//
//  Created by Luntu on 2020/07/27.
//  Copyright © 2020 Luntu. All rights reserved.
//

import Foundation

struct EventsDataModel {
    
    var fromDate: Date
    var toDate: Date
    var removalDate: Date
    var hasCheckedOut: Bool
    var isCheckedIn: Bool
    var registrationStatus: Int
    var status: Int
    var title: String
    var location: String
    var eventID: String
    var media:[Media]?
    
    private enum CodingKeys: String, CodingKey {
        case fromDate = "dateFrom"
        case toDate = "dateTo"
        case removalDate
        case hasCheckedOut
        case isCheckedIn
        case registrationStatus
        case status
        case title
        case location
        case eventID = "id"
        case media
    }
}

// MARK: - Decoder

extension EventsDataModel: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fromDate = try Date.from(string: container.decodeIfPresent(String.self, forKey: .fromDate) ?? "",
                                 format: DateFormats.SimpleDateFormat) ?? Date()
        toDate = try Date.from(string: container.decodeIfPresent(String.self, forKey: .toDate) ?? "",
                               format: DateFormats.SimpleDateFormat) ?? Date()
        removalDate = try Date.from(string: container.decodeIfPresent(String.self, forKey: .removalDate) ?? "",
                                    format: DateFormats.SimpleDateFormat) ?? Date()
        hasCheckedOut = try container.decodeIfPresent(Bool.self, forKey: .hasCheckedOut) ?? false
        isCheckedIn = try container.decodeIfPresent(Bool.self, forKey: .isCheckedIn) ?? false
        registrationStatus = try container.decodeIfPresent(Int.self, forKey: .registrationStatus) ?? -1
        status = try container.decodeIfPresent(Int.self, forKey: .status) ?? -1
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        location = try container.decodeIfPresent(String.self, forKey: .location) ?? ""
        eventID = try container.decodeIfPresent(String.self, forKey: .eventID) ?? ""
        media = try container.decodeIfPresent([Media].self, forKey: .media)
    }
}

struct Media {
    
    var mediaURL: String
    
    private enum CodingKeys: String, CodingKey {
        case mediaURL = "getMediaUrl"
    }
}

// MARK: - Decoder

extension Media: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mediaURL = try container.decodeIfPresent(String.self, forKey: .mediaURL) ?? ""
    }
}
