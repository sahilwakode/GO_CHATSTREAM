import React, { Component } from 'react';
import './ChatInput.scss';

class ChatInput extends Component {
  state = {
    message: '',
  };

  handleInput = (e) => {
    this.setState({ message: e.target.value });
  };

  handleKeyPress = (e) => {
    if (e.key === 'Enter' && this.state.message.trim()) {
      this.props.send(e);
      this.setState({ message: '' });
    }
  };

  render() {
    return (
      <div className="chat-input">
        <div className="chat-input__container">
          <input
            value={this.state.message}
            onChange={this.handleInput}
            onKeyDown={this.handleKeyPress}
            placeholder="Type your message..."
            className="chat-input__field"
          />
          <button
            className="chat-input__send"
            onClick={(e) => {
              if (this.state.message.trim()) {
                this.props.send(e);
                this.setState({ message: '' });
              }
            }}
            disabled={!this.state.message}
          >
            Send
          </button>
        </div>
      </div>
    );
  }
}

export default ChatInput;
