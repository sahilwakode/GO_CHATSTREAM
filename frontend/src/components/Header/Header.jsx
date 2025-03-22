import React from 'react';
import './Header.scss';

const Header = () => (
  <header className='header'>
    <div className='header__container'>
      <h1 className='header__title'>
        <span className='header__accent'>Sahil</span>ChatStream
      </h1>
      <div className='header__divider'></div>
      <nav className='header__nav'>
        <a href="/" className='header__nav-item'>Home</a>
        <a 
          href="https://www.linkedin.com/in/sahilwakode/" 
          target="_blank" 
          rel="noopener noreferrer" 
          className='header__nav-item'
        >
          Queries
        </a>
        <a 
          href="tel:+917400347477" 
          className='header__nav-item'
        >
          Contact
        </a>
      </nav>
    </div>
  </header>
);

export default Header;
