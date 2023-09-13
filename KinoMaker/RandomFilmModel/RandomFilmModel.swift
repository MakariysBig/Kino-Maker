// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
// RandomFilmModel
import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct RandomFilmModel: Codable {
    let docs: [FilmInfo]
    let total, limit, page, pages: Int
}

// MARK: - Doc
struct FilmInfo: Codable {
    let externalId: ExternalID
    let rating, votes: Rating
    let movieLength, id: Int
//    let type: TypeEnum
    let name, description: String
    let year: Int
    let poster: Poster
    let genres, countries: [Country]
    let alternativeName, enName: String?
    let names: [NameElement]
    let shortDescription: String?
    let logo: Logo?
    let watchability: Watchability
    let color: String?
//    let releaseYears: [JSONAny]?

}

// MARK: - Country
struct Country: Codable {
    let name: String
}

// MARK: - ExternalID
struct ExternalID: Codable {
    let kpHD: String?
    let imdb: String?
    let tmdb: Int?
}

// MARK: - Logo
struct Logo: Codable {
    let url: String?
}

// MARK: - NameElement
struct NameElement: Codable {
    let name: String
    let language, type: String?
}

// MARK: - Poster
struct Poster: Codable {
    let url, previewURL: String

    enum CodingKeys: String, CodingKey {
        case url
        case previewURL = "previewUrl"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let kp, imdb, filmCritics, russianFilmCritics: Double
    let ratingAwait: Int?

    enum CodingKeys: String, CodingKey {
        case kp, imdb, filmCritics, russianFilmCritics
        case ratingAwait = "await"
    }
}

enum TypeEnum: String, Codable {
    case movie = "movie"
}

// MARK: - Watchability
struct Watchability: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let name: NameEnum
    let logo: Logo
    let url: String
}

enum NameEnum: String, Codable {
    case ctcRu = "ctc.ru"
    case dомашний = "Dомашний"
    case kinopoiskHD = "Kinopoisk HD"
    case kion = "KION"
    case moreTv = "more.tv"
    case okko = "Okko"
    case premier = "PREMIER"
    case start = "START"
    case the24Тв = "24ТВ"
    case viju = "viju"
    case wink = "Wink"
    case большоеТВ = "Большое ТВ"
    case иви = "Иви"
    case кино1ТВ = "Кино1ТВ"
    case кинотеатрWink = "Кинотеатр Wink"
    case нтвПЛЮСОнлайнТВ = "НТВ-ПЛЮС Онлайн ТВ"
    case смотрёшка = "Смотрёшка"
    case триколорКиноИТВ = "Триколор Кино и ТВ"
}
