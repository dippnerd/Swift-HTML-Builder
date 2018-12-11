//
//  HTML.swift
//
//  Created by Aaron Dippner on 12/10/18.
//

import Foundation

/**
 A light-weight struct for creating HTML strings rapidly. Great for formatting logs and other data
 */
struct HTML {
    /**
     Represents a single HTML Node
     */
    class Node {
        let element: Tag
        var children: [Node]
        let value: String
        let attributes: [String: String]?
        
        /**
         Creates a single Node of element type Tag, with an array of children Nodes and an optional Dictionary of attributes
         
         - Parameter element: The HTML element type this Node represents of the Tag type
         - Parameter children: Array of child Nodes
         - Parameter attributes: A Dictionary of HTML attributes, like "class":"info"
         */
        init(element: Tag, children: [Node], attributes: [String: String]? = nil) {
            self.element = element
            self.children = children
            self.attributes = attributes
            self.value = ""
        }
        
        /**
         Creates a single Node of element type Tag, with a String value and an optional Dictionary of attributes
         
         - Parameter element: The HTML element type this Node represents of the Tag type
         - Parameter value: String value of Node
         - Parameter attributes: A Dictionary of HTML attributes, like "class":"info"
         */
        init(element: Tag, value: String = "", attributes: [String: String]? = nil) {
            self.element = element
            self.value = value
            self.attributes = attributes
            self.children = [Node]()
        }
        
        /**
         Creates a single Node of element type Tag, with a String value and an optional Dictionary of attributes
         
         - Returns: String of formatted text representing this Node and any children it contains as HTML
         */
        var text: String {
            let stringAttributes = getAttributes(from: attributes)
            var returnString = "<\(element)\(stringAttributes)"
            
            if children.count > 0 {
                var childNodes = ""
                for child in children {
                    childNodes += child.text
                }
                returnString += ">\(childNodes)</\(element)>\n"
            } else if value != "" {
                returnString += ">\(value)</\(element)>\n"
            } else {
                returnString += "/>\n"
            }
            return returnString
        }
    }
    
    /**
     Produces an HTML document which already contains the basic structure including doctype, header, stylesheet (which you can supply as a string) and body tag, the node supplied will fill in the body
     
     - Parameter nodes: Nodes to place inside of body tag
     - Parameter style: Stylesheet to include in header
     - Returns: A String representing the full HTML document
     */
    static func doc(using nodes: [Node], style: String) -> String {
        let html = Node(element: .html, children: [
            Node(element: .head, children: [
                Node(element: .style, value: style)
                ]),
            Node(element: .body, children: nodes)
            ])
        
        return """
        <!DOCTYPE html>
        \(html.text.trimmingCharacters(in: .whitespacesAndNewlines))
        """
    }
    
    /**
     Parse HTML Nodes as-is, without adding doctype, body, stylesheet etc
     
     - Parameter nodes: Array of Nodes to parse
     - Returns: A String representation of the HTML Nodes
     */
    static func parse(using nodes: [Node]) -> String {
        var html: String = ""
        for node in nodes {
            html += node.text
        }
        return html.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /**
     Creates a string from the dictionary provided, formatted as key="value"
     
     - Parameter dictionary: A dictionary of attributes to be converted into an HTML string
     */
    private static func getAttributes(from dictionary: [String: String]?) -> String {
        guard let attributes = dictionary else {
            return ""
        }
        
        var stringAttributes: String = ""
        for (key, value) in attributes {
            stringAttributes += " \(key)=\"\(value)\""
        }
        return stringAttributes
    }
    
    /**
     Supported HTML tags
     */
    enum Tag:String {
        case a
        case b
        case body
        case br
        case div
        case em
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
        case head
        case header
        case hr
        case html
        case i
        case li
        case meta
        case ol
        case p
        case span
        case strong
        case style
        case sub
        case sup
        case table
        case tbody
        case td
        case text
        case tfoot
        case th
        case thead
        case title
        case tr
        case u
        case ul
    }
}
