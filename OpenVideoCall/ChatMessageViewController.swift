//
//  ChatMessageViewController.swift
//  OpenVideoCall
//
//  Created by GongYuhua on 16/8/15.
//  Copyright © 2016年 Agora. All rights reserved.
//

import Cocoa

class ChatMessageViewController: NSViewController {
    
    @IBOutlet weak var messageTableView: NSTableView!
    
    fileprivate var messageList = [Message]()
    
    func appendChat(_ text: String, fromUid uid: Int64) {
        let message = Message(text: text, type: .chat)
        appendMessage(message)
    }
    
    func appendAlert(_ text: String) {
        let message = Message(text: text, type: .alert)
        appendMessage(message)
    }
}

private extension ChatMessageViewController {
    func appendMessage(_ message: Message) {
        messageList.append(message)
        
        var deleted: Message?
        if messageList.count > 20 {
            deleted = messageList.removeFirst()
        }
        
        updateMessageTableWithDeletedMesage(deleted)
    }
    
    func updateMessageTableWithDeletedMesage(_ deleted: Message?) {
        guard let tableView = messageTableView else {
            return
        }
        
        if deleted != nil {
            tableView.removeRows(at: IndexSet(integer: 0), withAnimation: NSTableViewAnimationOptions())
        }
        
        let lastRow = messageList.count - 1
        tableView.insertRows(at: IndexSet(integer: lastRow), withAnimation: NSTableViewAnimationOptions())
        tableView.scrollRowToVisible(lastRow)
    }
}

extension ChatMessageViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return messageList.count
    }
}

extension ChatMessageViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "messageCell", owner: self) as! ChatMessageCellView
        let message = messageList[row]
        cell.setMessage(message)
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let defaultHeight: CGFloat = 24
        let string: NSString = messageList[row].text as NSString
        
        let column = tableView.tableColumns.first!
        let width = column.width - 24
        let textRect = string.boundingRect(with: NSMakeSize(width, 0), options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: 12)])
        
        var textHeight = textRect.height + 6
        
        if textHeight < defaultHeight {
            textHeight = defaultHeight;
        }
        return textHeight;
    }
}
