import React, { Component } from 'react';
import './Message.scss';

class Message extends Component {
  constructor(props) {
    super(props);
    try {
      this.state = {
        message: JSON.parse(this.props.message),
        isUser: props.isUser || false
      };
    } catch (error) {
      this.state = {
        message: { body: this.props.message },
        isUser: false
      };
    }
  }

  render() {
    const { body, timestamp } = this.state.message;
    const { isUser } = this.state;

    return (
      <div className={`message ${isUser ? 'message--user' : ''}`}>
        <div className="message__content">
          <p className="message__text">{body}</p>
          {timestamp && (
            <span className="message__time">
              {new Date(timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
            </span>
          )}
        </div>
        {isUser && <div className="message__status">✓✓</div>}
      </div>
    );
  }
}

export default Message;
