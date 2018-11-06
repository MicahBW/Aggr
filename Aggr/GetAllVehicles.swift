//
//  GetBirdVehicles.swift
//  Aggr
//
//  Created by Micah Byrne Wolfsohn on 9/13/18.
//  Copyright © 2018 AggrCo. All rights reserved.
//

import Foundation
import CoreLocation
import Apollo

var vehList = Set<Vehicle>()

public enum VehicleType: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    /// A bike, something with two wheel, a handlebar and a saddle
    case bike
    /// A scooter, like a bike without saddle. ¯\_(⊙︿⊙)_/¯
    case scooter
    /// A motor-scooter
    case motorscooter
    /// A station of vehicles.
    case station
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)
    
    
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "BIKE": self = .bike
        case "SCOOTER": self = .scooter
        case "MOTORSCOOTER": self = .motorscooter
        case "STATION": self = .station
        default: self = .__unknown(rawValue)
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .bike: return "BIKE"
        case .scooter: return "SCOOTER"
        case .motorscooter: return "MOTORSCOOTER"
        case .station: return "STATION"
        case .__unknown(let value): return value
        }
    }
    
    public static func == (lhs: VehicleType, rhs: VehicleType) -> Bool {
        switch (lhs, rhs) {
        case (.bike, .bike): return true
        case (.scooter, .scooter): return true
        case (.motorscooter, .motorscooter): return true
        case (.station, .station): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
        }
    }
}

/// All vehicle's attributes
public enum VehicleAttribute: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    /// This vehicle has gears
    case gears
    /// This vehicle is electric
    case electric
    /// This vehicle has a child seat
    case childSeat
    /// This vehicle can handle heavy loads. Can have 3 wheels
    case cargo
    /// Bike for 2 or 3 peoples. Because it's funnier
    case tandem
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "GEARS": self = .gears
        case "ELECTRIC": self = .electric
        case "CHILD_SEAT": self = .childSeat
        case "CARGO": self = .cargo
        case "TANDEM": self = .tandem
        default: self = .__unknown(rawValue)
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .gears: return "GEARS"
        case .electric: return "ELECTRIC"
        case .childSeat: return "CHILD_SEAT"
        case .cargo: return "CARGO"
        case .tandem: return "TANDEM"
        case .__unknown(let value): return value
        }
    }
    
    public static func == (lhs: VehicleAttribute, rhs: VehicleAttribute) -> Bool {
        switch (lhs, rhs) {
        case (.gears, .gears): return true
        case (.electric, .electric): return true
        case (.childSeat, .childSeat): return true
        case (.cargo, .cargo): return true
        case (.tandem, .tandem): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
        }
    }
}

public final class GetAllVehiclesQuery: GraphQLQuery {
    public let operationDefinition =
    "query GetAllVehicles($lat: Float!, $lng: Float!) {\n  vehicles(lat: $lat, lng: $lng) {\n    __typename\n    id\n    type\n    attributes\n    lat\n    lng\n    provider {\n      __typename\n      name\n    }\n  }\n}"
    
    public var lat: Double
    public var lng: Double
    
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    public var variables: GraphQLMap? {
        return ["lat": lat, "lng": lng]
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes = ["Query"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("vehicles", arguments: ["lat": GraphQLVariable("lat"), "lng": GraphQLVariable("lng")], type: .list(.object(Vehicle.selections))),
            ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(vehicles: [Vehicle?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "Query", "vehicles": vehicles.flatMap { (value: [Vehicle?]) -> [ResultMap?] in value.map { (value: Vehicle?) -> ResultMap? in value.flatMap { (value: Vehicle) -> ResultMap in value.resultMap } } }])
        }
        
        /// Query available vehicles according to location
        public var vehicles: [Vehicle?]? {
            get {
                return (resultMap["vehicles"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Vehicle?] in value.map { (value: ResultMap?) -> Vehicle? in value.flatMap { (value: ResultMap) -> Vehicle in Vehicle(unsafeResultMap: value) } } }
            }
            set {
                resultMap.updateValue(newValue.flatMap { (value: [Vehicle?]) -> [ResultMap?] in value.map { (value: Vehicle?) -> ResultMap? in value.flatMap { (value: Vehicle) -> ResultMap in value.resultMap } } }, forKey: "vehicles")
            }
        }
        
        public struct Vehicle: GraphQLSelectionSet {
            public static let possibleTypes = ["Bird", "Byke", "CallABike", "Cityscoot", "Coup", "Donkey", "GobeeBike", "Hellobike", "IndigoWheel", "Jump", "Lime", "Mobike", "Nextbike", "Obike", "Ofo", "Pony", "Spin", "WhiteBikes", "Wind", "Yobike"]
            
            public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .scalar(String.self)),
                GraphQLField("type", type: .scalar(VehicleType.self)),
                GraphQLField("attributes", type: .list(.scalar(VehicleAttribute.self))),
                GraphQLField("lat", type: .scalar(Double.self)),
                GraphQLField("lng", type: .scalar(Double.self)),
                GraphQLField("provider", type: .object(Provider.selections)),
                ]
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public static func makeBird(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Bird", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeByke(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Byke", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeCallABike(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "CallABike", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeCityscoot(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Cityscoot", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeCoup(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Coup", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeDonkey(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Donkey", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeGobeeBike(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "GobeeBike", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeHellobike(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Hellobike", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeIndigoWheel(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "IndigoWheel", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeJump(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Jump", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeLime(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Lime", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeMobike(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Mobike", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeNextbike(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Nextbike", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeObike(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Obike", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeOfo(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Ofo", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makePony(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Pony", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeSpin(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Spin", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeWhiteBikes(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "WhiteBikes", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeWind(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Wind", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public static func makeYobike(id: String? = nil, type: VehicleType? = nil, attributes: [VehicleAttribute?]? = nil, lat: Double? = nil, lng: Double? = nil, provider: Provider? = nil) -> Vehicle {
                return Vehicle(unsafeResultMap: ["__typename": "Yobike", "id": id, "type": type, "attributes": attributes, "lat": lat, "lng": lng, "provider": provider.flatMap { (value: Provider) -> ResultMap in value.resultMap }])
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            /// The provider id
            public var id: String? {
                get {
                    return resultMap["id"] as? String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "id")
                }
            }
            
            /// The object's type
            public var type: VehicleType? {
                get {
                    return resultMap["type"] as? VehicleType
                }
                set {
                    resultMap.updateValue(newValue, forKey: "type")
                }
            }
            
            /// The vehicle's attributes
            public var attributes: [VehicleAttribute?]? {
                get {
                    return resultMap["attributes"] as? [VehicleAttribute?]
                }
                set {
                    resultMap.updateValue(newValue, forKey: "attributes")
                }
            }
            
            /// The vehicle's latitude
            public var lat: Double? {
                get {
                    return resultMap["lat"] as? Double
                }
                set {
                    resultMap.updateValue(newValue, forKey: "lat")
                }
            }
            
            /// The vehicle's longitude
            public var lng: Double? {
                get {
                    return resultMap["lng"] as? Double
                }
                set {
                    resultMap.updateValue(newValue, forKey: "lng")
                }
            }
            
            public var provider: Provider? {
                get {
                    return (resultMap["provider"] as? ResultMap).flatMap { Provider(unsafeResultMap: $0) }
                }
                set {
                    resultMap.updateValue(newValue?.resultMap, forKey: "provider")
                }
            }
            
            public struct Provider: GraphQLSelectionSet {
                public static let possibleTypes = ["Provider"]
                
                public static let selections: [GraphQLSelection] = [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .scalar(String.self)),
                    ]
                
                public private(set) var resultMap: ResultMap
                
                public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                }
                
                public init(name: String? = nil) {
                    self.init(unsafeResultMap: ["__typename": "Provider", "name": name])
                }
                
                public var __typename: String {
                    get {
                        return resultMap["__typename"]! as! String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                    }
                }
                
                /// Provider name
                public var name: String? {
                    get {
                        return resultMap["name"] as? String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "name")
                    }
                }
            }
        }
    }
}


func makeAPICall(ofLocation location: CLLocationCoordinate2D){
    let apollo: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["content-type": "application/json"] // Replace `<token>`
        
        let url = URL(string: "https://api.multicycles.org/v1?access_token=UgOWIrrzGv4jdmU1FmxnbZSydfqJDXuI")!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    apollo.fetch(query: GetAllVehiclesQuery(lat: location.latitude, lng: location.longitude)) { (result, error) in
        guard let data = result?.data else { return }
        for v in data.vehicles ?? [] {
            let lat: Double = v?.lat ?? 0.0
            let long: Double = v?.lng ?? 0.0
            let CLLC2D: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
            let companyString = v?.provider?.name ?? "null"
            var companyObject: Company
            switch (companyString) {
            case "Bird":
                companyObject = Company.bird
                break
            case "Lime":
                companyObject = Company.limeBike
                break
            case "Ofo":
                companyObject = Company.ofo
                break
            default:
                companyObject = Company.limeBike
                break
            }
            let typeObject = v?.type ?? VehicleType(rawValue: "null")
            let scooterInfoObject = ScooterData.init(batteryCharge: 100)
            let currentVehicle = Vehicle(location: CLLC2D, company: companyObject, type: typeObject!, scooterInfo: scooterInfoObject)
            vehList.insert(currentVehicle)
        }
    }
}

func initAPICall(ofLocation location: CLLocationCoordinate2D){
    let apollo: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["content-type": "application/json"] // Replace `<token>`
        
        let url = URL(string: "https://api.multicycles.org/v1?access_token=UgOWIrrzGv4jdmU1FmxnbZSydfqJDXuI")!
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }()
    apollo.fetch(query: GetAllVehiclesQuery(lat: location.latitude, lng: location.longitude)) { (result, error) in
        guard let data = result?.data else { return }
        for v in data.vehicles ?? [] {
            let lat: Double = v?.lat ?? 0.0
            let long: Double = v?.lng ?? 0.0
            let CLLC2D: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
            let companyString = v?.provider?.name ?? "null"
            var companyObject: Company
            switch (companyString) {
            case "Bird":
                companyObject = Company.bird
                break
            case "Lime":
                companyObject = Company.limeBike
                break
            case "Ofo":
                companyObject = Company.ofo
                break
            default:
                companyObject = Company.limeBike
                break
            }
            let typeObject = v?.type ?? VehicleType(rawValue: "null")
            let scooterInfoObject = ScooterData.init(batteryCharge: 100)
            let currentVehicle = Vehicle(location: CLLC2D, company: companyObject, type: typeObject!, scooterInfo: scooterInfoObject)
            vehList.insert(currentVehicle)
        }
    }
        apollo.fetch(query: GetAllVehiclesQuery(lat: location.latitude - 0.01, lng: location.longitude)) { (result, error) in
            guard let data = result?.data else { return }
            for v in data.vehicles ?? [] {
                let lat: Double = v?.lat ?? 0.0
                let long: Double = v?.lng ?? 0.0
                let CLLC2D: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
                let companyString = v?.provider?.name ?? "null"
                var companyObject: Company
                switch (companyString) {
                case "Bird":
                    companyObject = Company.bird
                    break
                case "Lime":
                    companyObject = Company.limeBike
                    break
                case "Ofo":
                    companyObject = Company.ofo
                    break
                default:
                    companyObject = Company.limeBike
                    break
                }
                let typeObject = v?.type ?? VehicleType(rawValue: "null")
                let scooterInfoObject = ScooterData.init(batteryCharge: 100)
                let currentVehicle = Vehicle(location: CLLC2D, company: companyObject, type: typeObject!, scooterInfo: scooterInfoObject)
                vehList.insert(currentVehicle)
            }
        }
        apollo.fetch(query: GetAllVehiclesQuery(lat: location.latitude + 0.01, lng: location.longitude)) { (result, error) in
            guard let data = result?.data else { return }
            for v in data.vehicles ?? [] {
                let lat: Double = v?.lat ?? 0.0
                let long: Double = v?.lng ?? 0.0
                let CLLC2D: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
                let companyString = v?.provider?.name ?? "null"
                var companyObject: Company
                switch (companyString) {
                case "Bird":
                    companyObject = Company.bird
                    break
                case "Lime":
                    companyObject = Company.limeBike
                    break
                case "Ofo":
                    companyObject = Company.ofo
                    break
                default:
                    companyObject = Company.limeBike
                    break
                }
                let typeObject = v?.type ?? VehicleType(rawValue: "null")
                let scooterInfoObject = ScooterData.init(batteryCharge: 100)
                let currentVehicle = Vehicle(location: CLLC2D, company: companyObject, type: typeObject!, scooterInfo: scooterInfoObject)
                vehList.insert(currentVehicle)
            }
        }
        apollo.fetch(query: GetAllVehiclesQuery(lat: location.latitude, lng: location.longitude + 0.01)) { (result, error) in
            guard let data = result?.data else { return }
            for v in data.vehicles ?? [] {
                let lat: Double = v?.lat ?? 0.0
                let long: Double = v?.lng ?? 0.0
                let CLLC2D: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
                let companyString = v?.provider?.name ?? "null"
                var companyObject: Company
                switch (companyString) {
                case "Bird":
                    companyObject = Company.bird
                    break
                case "Lime":
                    companyObject = Company.limeBike
                    break
                case "Ofo":
                    companyObject = Company.ofo
                    break
                default:
                    companyObject = Company.limeBike
                    break
                }
                let typeObject = v?.type ?? VehicleType(rawValue: "null")
                let scooterInfoObject = ScooterData.init(batteryCharge: 100)
                let currentVehicle = Vehicle(location: CLLC2D, company: companyObject, type: typeObject!, scooterInfo: scooterInfoObject)
                vehList.insert(currentVehicle)
            }
        }
        apollo.fetch(query: GetAllVehiclesQuery(lat: location.latitude, lng: location.longitude - 0.01)) { (result, error) in
            guard let data = result?.data else { return }
            for v in data.vehicles ?? [] {
                let lat: Double = v?.lat ?? 0.0
                let long: Double = v?.lng ?? 0.0
                let CLLC2D: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: lat, longitude: long)
                let companyString = v?.provider?.name ?? "null"
                var companyObject: Company
                switch (companyString) {
                case "Bird":
                    companyObject = Company.bird
                    break
                case "Lime":
                    companyObject = Company.limeBike
                    break
                case "Ofo":
                    companyObject = Company.ofo
                    break
                default:
                    companyObject = Company.limeBike
                    break
                }
                let typeObject = v?.type ?? VehicleType(rawValue: "null")
                let scooterInfoObject = ScooterData.init(batteryCharge: 100)
                let currentVehicle = Vehicle(location: CLLC2D, company: companyObject, type: typeObject!, scooterInfo: scooterInfoObject)
                vehList.insert(currentVehicle)
            }
        }
}

func getVehList() -> Set<Vehicle> {
    return vehList
}
