import UIKit
import Spring
class DetailViewController: UIViewController {
    var entryRow: Int = 0
    var noteData: String = ""
    @IBOutlet weak var textView: UITextView!
    var textViewBottomConstraint: NSLayoutConstraint?
    var isTyping = false
    var bubbleSyncColor = UIColor.white
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
        } else {
        }
        self.navigationController?.navigationBar.tintColor = UIColor.black.lighter()
        self.view.backgroundColor = self.bubbleSyncColor
        textView.delegate = self
        textView.text = noteData
        textViewBottomConstraint = NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -10)
        view.addConstraint(textViewBottomConstraint!)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let rectInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
                textViewBottomConstraint?.constant = isKeyboardShowing ? -rectInfo.height : -10
                isTyping = isKeyboardShowing ? true : false
                UIView.animate(withDuration: 0, delay: 0, options: .curveEaseIn, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { (completed) in
                    UIView.animate(withDuration: 0.35, animations: {
                    })
                })
            }
        }
    }
}
extension DetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        EventManager.shared.update(row: entryRow, content: nil, note: textView.text,calendarEvent: nil, alarmDate: nil, alarmIntervalOffset: nil, isSetNotification: nil)
        if let event = EventManager.shared.read(row: entryRow) {
            if let calendarEventID = event.calendarEventID,
                let content = event.content,
                let note = event.note,
                let date = event.alarmStartTime{
                let alarmIntervalOffset = event.alarmIntervalOffset
                let isNotification = event.isSetNotification
                print(content)
                print(note)
                print(date)
                print(event.alarmIntervalOffset)
                removeEvent(identifier: calendarEventID)
                let calendarIdentifier = insertEvent(title: content, notes: note, startDate: date as Date, EndDate: date as Date, relativeOffset: -alarmIntervalOffset)
                EventManager.shared.update(row: entryRow,
                                           content: content,
                                           note: note,
                                           calendarEvent: calendarIdentifier,
                                           alarmDate: date as NSDate,
                                           alarmIntervalOffset: alarmIntervalOffset,
                                           isSetNotification: isNotification)
            }
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
    func textViewDidChange(_ textView: UITextView) {
    }
}
