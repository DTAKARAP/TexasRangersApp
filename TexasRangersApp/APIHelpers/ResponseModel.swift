//
//  EventModel.swift
//  TexasRangersApp
//
//  Created by divya akarapu on 11/25/20.


import Foundation

// MARK: - Events
public struct Events: Codable {
    public let events: [Event]?
    public let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case events = "events"
        case meta = "meta"
    }

    public init(events: [Event]?, meta: Meta?) {
        self.events = events
        self.meta = meta
    }
}

// MARK: - Event
public struct Event: Codable {
    public let type: String?
    public let id: Int?
    public let datetimeUTC: String?
    public let performers: [Performer]?
    public let venue: Venue?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case datetimeUTC = "datetime_utc"
        case performers = "performers"
        case venue = "venue"
    }

    public init(type: String?, id: Int?, datetimeUTC: String?, performers: [Performer]?, venue: Venue?) {
        self.type = type
        self.id = id
        self.datetimeUTC = datetimeUTC
        self.performers = performers
        self.venue = venue
    }
}

// MARK: - Performer
public struct Performer: Codable {
    public let type: String?
    public let name: String?
    public let image: String?
    public let id: Int?
    public let images: PerformerImages?
    public let divisions: [Division]?
    public let hasUpcomingEvents: Bool?
    public let primary: Bool?
    public let stats: PerformerStats?
    public let taxonomies: [Taxonomy]?
    public let imageAttribution: String?
    public let url: String?
    public let score: Double?
    public let slug: String?
    public let homeVenueID: Int?
    public let shortName: String?
    public let numUpcomingEvents: Int?
    public let colors: Colors?
    public let imageLicense: String?
    public let popularity: Int?
    public let homeTeam: Bool?
    public let location: Location?
    public let awayTeam: Bool?
    public let genres: [Genre]?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case name = "name"
        case image = "image"
        case id = "id"
        case images = "images"
        case divisions = "divisions"
        case hasUpcomingEvents = "has_upcoming_events"
        case primary = "primary"
        case stats = "stats"
        case taxonomies = "taxonomies"
        case imageAttribution = "image_attribution"
        case url = "url"
        case score = "score"
        case slug = "slug"
        case homeVenueID = "home_venue_id"
        case shortName = "short_name"
        case numUpcomingEvents = "num_upcoming_events"
        case colors = "colors"
        case imageLicense = "image_license"
        case popularity = "popularity"
        case homeTeam = "home_team"
        case location = "location"
        case awayTeam = "away_team"
        case genres = "genres"
    }

    public init(type: String?, name: String?, image: String?, id: Int?, images: PerformerImages?, divisions: [Division]?, hasUpcomingEvents: Bool?, primary: Bool?, stats: PerformerStats?, taxonomies: [Taxonomy]?, imageAttribution: String?, url: String?, score: Double?, slug: String?, homeVenueID: Int?, shortName: String?, numUpcomingEvents: Int?, colors: Colors?, imageLicense: String?, popularity: Int?, homeTeam: Bool?, location: Location?, awayTeam: Bool?, genres: [Genre]?) {
        self.type = type
        self.name = name
        self.image = image
        self.id = id
        self.images = images
        self.divisions = divisions
        self.hasUpcomingEvents = hasUpcomingEvents
        self.primary = primary
        self.stats = stats
        self.taxonomies = taxonomies
        self.imageAttribution = imageAttribution
        self.url = url
        self.score = score
        self.slug = slug
        self.homeVenueID = homeVenueID
        self.shortName = shortName
        self.numUpcomingEvents = numUpcomingEvents
        self.colors = colors
        self.imageLicense = imageLicense
        self.popularity = popularity
        self.homeTeam = homeTeam
        self.location = location
        self.awayTeam = awayTeam
        self.genres = genres
    }
}

// MARK: - Colors
public struct Colors: Codable {
    public let all: [String]?
    public let iconic: String?
    public let primary: [String]?

    enum CodingKeys: String, CodingKey {
        case all = "all"
        case iconic = "iconic"
        case primary = "primary"
    }

    public init(all: [String]?, iconic: String?, primary: [String]?) {
        self.all = all
        self.iconic = iconic
        self.primary = primary
    }
}

// MARK: - Division
public struct Division: Codable {
    public let taxonomyID: Int?
    public let shortName: String?
    public let displayName: String?
    public let displayType: String?
    public let divisionLevel: Int?
    public let slug: String?

    enum CodingKeys: String, CodingKey {
        case taxonomyID = "taxonomy_id"
        case shortName = "short_name"
        case displayName = "display_name"
        case displayType = "display_type"
        case divisionLevel = "division_level"
        case slug = "slug"
    }

    public init(taxonomyID: Int?, shortName: String?, displayName: String?, displayType: String?, divisionLevel: Int?, slug: String?) {
        self.taxonomyID = taxonomyID
        self.shortName = shortName
        self.displayName = displayName
        self.displayType = displayType
        self.divisionLevel = divisionLevel
        self.slug = slug
    }
}

// MARK: - Genre
public struct Genre: Codable {
    public let id: Int?
    public let name: String?
    public let slug: String?
    public let primary: Bool?
    public let images: GenreImages?
    public let image: String?
    public let documentSource: DocumentSource?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case primary = "primary"
        case images = "images"
        case image = "image"
        case documentSource = "document_source"
    }

    public init(id: Int?, name: String?, slug: String?, primary: Bool?, images: GenreImages?, image: String?, documentSource: DocumentSource?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.primary = primary
        self.images = images
        self.image = image
        self.documentSource = documentSource
    }
}

// MARK: - DocumentSource
public struct DocumentSource: Codable {
    public let sourceType: String?
    public let generationType: String?

    enum CodingKeys: String, CodingKey {
        case sourceType = "source_type"
        case generationType = "generation_type"
    }

    public init(sourceType: String?, generationType: String?) {
        self.sourceType = sourceType
        self.generationType = generationType
    }
}

// MARK: - GenreImages
public struct GenreImages: Codable {
    public let the1200X525: String?
    public let the1200X627: String?
    public let the136X136: String?
    public let the500_700: String?
    public let the800X320: String?
    public let banner: String?
    public let block: String?
    public let criteo130_160: String?
    public let criteo170_235: String?
    public let criteo205_100: String?
    public let criteo400_300: String?
    public let fb100X72: String?
    public let fb600_315: String?
    public let huge: String?
    public let ipadEventModal: String?
    public let ipadHeader: String?
    public let ipadMiniExplore: String?
    public let mongo: String?
    public let squareMid: String?
    public let triggitFbAd: String?

    enum CodingKeys: String, CodingKey {
        case the1200X525 = "1200x525"
        case the1200X627 = "1200x627"
        case the136X136 = "136x136"
        case the500_700 = "500_700"
        case the800X320 = "800x320"
        case banner = "banner"
        case block = "block"
        case criteo130_160 = "criteo_130_160"
        case criteo170_235 = "criteo_170_235"
        case criteo205_100 = "criteo_205_100"
        case criteo400_300 = "criteo_400_300"
        case fb100X72 = "fb_100x72"
        case fb600_315 = "fb_600_315"
        case huge = "huge"
        case ipadEventModal = "ipad_event_modal"
        case ipadHeader = "ipad_header"
        case ipadMiniExplore = "ipad_mini_explore"
        case mongo = "mongo"
        case squareMid = "square_mid"
        case triggitFbAd = "triggit_fb_ad"
    }

    public init(the1200X525: String?, the1200X627: String?, the136X136: String?, the500_700: String?, the800X320: String?, banner: String?, block: String?, criteo130_160: String?, criteo170_235: String?, criteo205_100: String?, criteo400_300: String?, fb100X72: String?, fb600_315: String?, huge: String?, ipadEventModal: String?, ipadHeader: String?, ipadMiniExplore: String?, mongo: String?, squareMid: String?, triggitFbAd: String?) {
        self.the1200X525 = the1200X525
        self.the1200X627 = the1200X627
        self.the136X136 = the136X136
        self.the500_700 = the500_700
        self.the800X320 = the800X320
        self.banner = banner
        self.block = block
        self.criteo130_160 = criteo130_160
        self.criteo170_235 = criteo170_235
        self.criteo205_100 = criteo205_100
        self.criteo400_300 = criteo400_300
        self.fb100X72 = fb100X72
        self.fb600_315 = fb600_315
        self.huge = huge
        self.ipadEventModal = ipadEventModal
        self.ipadHeader = ipadHeader
        self.ipadMiniExplore = ipadMiniExplore
        self.mongo = mongo
        self.squareMid = squareMid
        self.triggitFbAd = triggitFbAd
    }
}

// MARK: - PerformerImages
public struct PerformerImages: Codable {
    public let huge: String?

    enum CodingKeys: String, CodingKey {
        case huge = "huge"
    }

    public init(huge: String?) {
        self.huge = huge
    }
}

// MARK: - Location
public struct Location: Codable {
    public let lat: Double?
    public let lon: Double?

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }

    public init(lat: Double?, lon: Double?) {
        self.lat = lat
        self.lon = lon
    }
}

// MARK: - PerformerStats
public struct PerformerStats: Codable {
    public let eventCount: Int?

    enum CodingKeys: String, CodingKey {
        case eventCount = "event_count"
    }

    public init(eventCount: Int?) {
        self.eventCount = eventCount
    }
}

// MARK: - Taxonomy
public struct Taxonomy: Codable {
    public let id: Int?
    public let name: String?
    public let parentID: Int?
    public let documentSource: DocumentSource?
    public let rank: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case parentID = "parent_id"
        case documentSource = "document_source"
        case rank = "rank"
    }

    public init(id: Int?, name: String?, parentID: Int?, documentSource: DocumentSource?, rank: Int?) {
        self.id = id
        self.name = name
        self.parentID = parentID
        self.documentSource = documentSource
        self.rank = rank
    }
}

// MARK: - Meta
public struct Meta: Codable {
    public let total: Int?
    public let took: Int?
    public let page: Int?
    public let perPage: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case took = "took"
        case page = "page"
        case perPage = "per_page"
    }

    public init(total: Int?, took: Int?, page: Int?, perPage: Int?) {
        self.total = total
        self.took = took
        self.page = page
        self.perPage = perPage
    }
}

// MARK: - Venue
public struct Venue: Codable {
    public let state: String?
    public let nameV2: String?
    public let postalCode: String?
    public let name: String?
    public let timezone: String?
    public let url: String?
    public let score: Double?
    public let location: Location?
    public let address: String?
    public let country: String?
    public let hasUpcomingEvents: Bool?
    public let numUpcomingEvents: Int?
    public let city: String?
    public let slug: String?
    public let extendedAddress: String?
    public let id: Int?
    public let popularity: Int?
    public let metroCode: Int?
    public let capacity: Int?
    public let displayLocation: String?

    enum CodingKeys: String, CodingKey {
        case state = "state"
        case nameV2 = "name_v2"
        case postalCode = "postal_code"
        case name = "name"
        case timezone = "timezone"
        case url = "url"
        case score = "score"
        case location = "location"
        case address = "address"
        case country = "country"
        case hasUpcomingEvents = "has_upcoming_events"
        case numUpcomingEvents = "num_upcoming_events"
        case city = "city"
        case slug = "slug"
        case extendedAddress = "extended_address"
        case id = "id"
        case popularity = "popularity"
        case metroCode = "metro_code"
        case capacity = "capacity"
        case displayLocation = "display_location"
    }

    public init(state: String?, nameV2: String?, postalCode: String?, name: String?, timezone: String?, url: String?, score: Double?, location: Location?, address: String?, country: String?, hasUpcomingEvents: Bool?, numUpcomingEvents: Int?, city: String?, slug: String?, extendedAddress: String?, id: Int?, popularity: Int?, metroCode: Int?, capacity: Int?, displayLocation: String?) {
        self.state = state
        self.nameV2 = nameV2
        self.postalCode = postalCode
        self.name = name
        self.timezone = timezone
        self.url = url
        self.score = score
        self.location = location
        self.address = address
        self.country = country
        self.hasUpcomingEvents = hasUpcomingEvents
        self.numUpcomingEvents = numUpcomingEvents
        self.city = city
        self.slug = slug
        self.extendedAddress = extendedAddress
        self.id = id
        self.popularity = popularity
        self.metroCode = metroCode
        self.capacity = capacity
        self.displayLocation = displayLocation
    }
}


