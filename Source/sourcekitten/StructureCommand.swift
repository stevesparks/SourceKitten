//
//  StructureCommand.swift
//  SourceKitten
//
//  Created by JP Simard on 2015-01-07.
//  Copyright (c) 2015 SourceKitten. All rights reserved.
//

import Commandant
import SourceKittenFramework

struct StructureCommand: CommandProtocol {
    let verb = "structure"
    let function = "Print Swift structure information as JSON"
    
    struct Options: OptionsProtocol {
        let file: String
        let text: String
        
        static func create(file: String) -> (_ text: String) -> Options {
            return { text in
                self.init(file: file, text: text)
            }
        }
        
        static func evaluate(_ mode: CommandMode) -> Result<Options, CommandantError<SourceKittenError>> {
            return create
                <*> mode <| Option(key: "file", defaultValue: "", usage: "relative or absolute path of Swift file to parse")
                <*> mode <| Option(key: "text", defaultValue: "", usage: "Swift code text to parse")
        }
    }
    
    func run(_ options: Options) -> Result<(), SourceKittenError> {
        do {
            
            let path = "/Users/barbecuesteve/Documents/Code/BNR/crescendo-instructor/Instructor"
            let fm = FileManager.default
            
            let pathUrl = URL(fileURLWithPath: path)
            let enumerator = fm.enumerator(at: pathUrl, includingPropertiesForKeys: [.fileSizeKey], options: [], errorHandler: { url, error in
                print("Error from \(url): \(error)")
                return true
            })
            try enumerator?.forEach { url in
                if let url = url as? URL, url.pathExtension == "swift" {
                    try registerSwiftFile(at: url)
                }
            }
            
            if !options.file.isEmpty {
                if let file = File(path: options.file) {
                    print(try Structure(file: file))
                    return .success(())
                }
                return .failure(.readFailed(path: options.file))
            }
            if !options.text.isEmpty {
                print(try Structure(file: File(contents: options.text)))
            }
            return .success(())
        } catch {
            return .failure(.failed(error))
        }
    }
    
    func registerSwiftFile(at url: URL) throws {
        print("\(url) >")
        if let file = File(path: url.path) {
            let str = try Structure(file: file)
            if let name = str.dictionary["key.name"] {
                print("\(name)")
            }
            if let sub = str.dictionary["key.substructure"] {
                let ctx = LoggingContext(className: nil, fileName: url.path)
                sub.logYourself(with: ctx)
                //                print("sub \(sub)")
            }
        }
    }
}

struct LoggingContext {
    var className: String?
    var fileName: String?
    var indent: Int = 0

    func context(for subclass: String) -> LoggingContext {
        if let nm = className {
            return LoggingContext(className: [nm, subclass].joined(separator: "."), fileName: fileName)
        } else {
            return LoggingContext(className: subclass, fileName: fileName)
        }
    }

    var subcontext: LoggingContext {
        return LoggingContext(className: self.className, fileName: self.fileName, indent: self.indent + 2)
    }
}

func registerClassName(_ name: String, in context: LoggingContext) {
    print("---register class \(name)")
}

func registerFunctionName(_ name: String, in context: LoggingContext) {
    print("---register function \(name)")
}

extension SourceKitRepresentable {
    func logYourself(with context: LoggingContext) {
        if let arr = self as? [SourceKitRepresentable] {
            arr.forEach { $0.logYourself(with: context) }
        } else if let dict = self as? [String: SourceKitRepresentable] {
            examine(dict, with: context)
        }
    }

    func examine(_ dict: [String: SourceKitRepresentable], with context: LoggingContext) {
        guard let kindVal = dict["key.kind"] as? String else { return }
        let nm = dict["key.name"] as? String

        if let kind = SwiftDeclarationKind(rawValue: kindVal) {
            //                let nm = (nmlen == 0) ? "" : (dict["key.name"] as? String ?? "")
            kind.logYourself(nm, dict, with: context)
        } else if let kind = StatementKind(rawValue: kindVal) {
            kind.logYourself(nm, dict, with: context)
        } else if kindVal == "source.lang.swift.expr.call", let name = nm {
            print("call to \(name)")
            registerFunctionName(name, in: context)
        } else if kindVal.isEmpty {
            print("wazzat")
        } else {
            print("derp? \(kindVal)")
        }
    }
}

extension SwiftDeclarationKind {
    func logYourself(_ nm: String?, _ dict: [String: SourceKitRepresentable] = [:], with context: LoggingContext) {
        let spacer = String(repeating: " ", count: context.indent)
        switch self {
        case .functionMethodInstance:
            let name = "\(context.className ?? "").\(nm ?? "NM")"
            registerFunctionName(name, in: context)
            print("\(spacer)\(name)")
        default:
            print("\(spacer) DFL \(self) \(nm ?? "NM")")
        }

        let containers: [SwiftDeclarationKind] = [.class, .enum, .struct, .protocol, .extension]
        if let sub = dict["key.substructure"] {
            let ctx = containers.contains(self) ? context.context(for: nm ?? "NM") : context
            sub.logYourself(with: ctx.subcontext)
        }
    }
}

extension StatementKind {
    func logYourself(_ nm: String?, _ dict: [String: SourceKitRepresentable] = [:], with context: LoggingContext) {
        let spacer = String(repeating: " ", count: context.indent)
        switch self {
        case .guard:
            print("\(spacer)-guard-")
        case .switch:
            print("\(spacer)-switch-")
        default:
            print("\(spacer) DFL \(self) \(nm ?? "NM")")
        }
    }
}
