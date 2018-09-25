//
//  AVLTree.swift
//  lista4eda2
//
//  Created by Matheus Azevedo on 24/09/2018.
//  Copyright © 2018 Matheus Azevedo. All rights reserved.
//

import UIKit

class AVLNode {
    var leftNode: AVLNode?
    var rightNode: AVLNode?
    let value: Int
    
    var parentNode: AVLNode?
    var height: Int
    
    init(value: Int, parent: AVLNode?) {
        self.value = value
        self.height = 1
        self.leftNode = nil
        self.rightNode = nil
        self.parentNode = parent
    }
    
    var balanceFactor: Int {
        let leftHeight = self.leftNode?.height ?? 0
        let rightHeight = self.rightNode?.height ?? 0
        return leftHeight - rightHeight
    }
    

}

class AVLTree {
    var root: AVLNode?
    
    func insert(value: Int) {
        if let root = self.root {
            insert(value: value, at: root)

        } else {
            root = AVLNode(value: value, parent: nil)
        }
    }
    
    private func insert(value: Int, at node: AVLNode) {
        if value < node.value {
            print("<----\(value)----")
            if let child = node.leftNode {
                insert(value: value, at: child)
            } else {
                node.leftNode = AVLNode(value: value, parent: node)
            }
        } else if value > node.value {
            print("----\(value)---->")
            if let child = node.rightNode {
                insert(value: value, at: child)
            } else {
                node.rightNode = AVLNode(value: value, parent: node)
            }
        } else {
            print("Valor já inserido")
        }
        
        node.height = 1 + max(node.leftNode?.height ?? 0, node.rightNode?.height ?? 0)
        balance(node: node)

    }
    
    func printOrdered(node: AVLNode) {
        if let left = node.leftNode {
            printOrdered(node: left)
        }
        print("\(node.value)", separator: " ", terminator: "- ")
        // |\(node.height)| _\(node.balanceFactor)_
        if let right = node.rightNode {
            printOrdered(node: right)
        }
    }
    
    func search(value: Int, node: AVLNode) -> AVLNode?{
        
        if value < node.value {
            if let left = node.leftNode {
                return search(value: value, node: left)
            } else {
                return nil
            }
        } else if value > node.value {
            if let right = node.rightNode {
                return search(value: value, node: right)
            } else {
                return nil
            }
        } else {
            return node
        }
    }
    
    private func balance(node: AVLNode) {
        
        if let left = node.leftNode {
            if node.balanceFactor > 1 && left.balanceFactor > 0{
                //Rotacao simples direita
                rightRotate(node: node)
            } else if node.balanceFactor > 1 && left.balanceFactor < 0{
                //Rotacao dupla esquerda-direita
                leftRotate(node: left)
                rightRotate(node: node)
            }
        }
        if let right = node.rightNode {
            if node.balanceFactor < 1 && right.balanceFactor < 0{
                //Rotacao simples esquerda
                leftRotate(node: node)
            } else if node.balanceFactor < 1 && right.balanceFactor > 0{
                //Rotacao dupla direita-esquerda
                rightRotate(node: right)
                leftRotate(node: node)
            }
        }
    }
    
    private func rightRotate(node: AVLNode) {
        let nodeParent = node.parentNode
        
        if let head = node.leftNode {
            let child:AVLNode? = head.rightNode
            
            head.rightNode = node
            node.parentNode = head
            
            node.leftNode = child
            child?.parentNode = node
      
            
            if nodeParent == nil {
                head.parentNode = nil
                root = head
            } else {
                head.parentNode = nodeParent
                if head.parentNode?.leftNode?.value == node.value {
                    nodeParent?.leftNode = head
                } else {
                    nodeParent?.rightNode = head
                }
            }
            node.height = 1 + max(node.leftNode?.height ?? 0, node.rightNode?.height ?? 0)
            head.height = 1 + max(head.leftNode?.height ?? 0, head.rightNode?.height ?? 0)
        }
    }
    
    private func leftRotate(node: AVLNode) {
        let nodeParent = node.parentNode
        
        if let head = node.rightNode {
            let child:AVLNode? = head.leftNode
            
            head.leftNode = node
            node.parentNode = head

            node.rightNode = child
            child?.parentNode = node
  
                
            if nodeParent == nil {
                head.parentNode = nil
                root = head
            } else {
                head.parentNode = nodeParent
                if head.parentNode?.leftNode?.value == node.value {
                    nodeParent?.leftNode = head
                } else {
                    nodeParent?.rightNode = head
                }
            }
            node.height = 1 + max(node.leftNode?.height ?? 0, node.rightNode?.height ?? 0)
            head.height = 1 + max(head.leftNode?.height ?? 0, head.rightNode?.height ?? 0)
        }
    }
    
    
    
}
