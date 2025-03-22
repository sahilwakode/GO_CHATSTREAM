import React, { Component } from 'react';
import './ChatHistory.scss';
import Message from '../Message/Message';

class ChatHistory extends Component {
  render() {
    return (
      <div className='chat-history'>
        <div className='chat-history__header'>
          <h1 className='chat-history__title'>Conversation History</h1>
        </div>
        <div className='chat-history__messages'>
          {this.props.chatHistory.map(msg => (
            <Message 
              key={msg.timeStamp} 
              message={msg.data} 
            />
          ))}
        </div>
      </div>
    );
  }
}

export default ChatHistory;
