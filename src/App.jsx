import React from 'react';
import { useState } from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import SplashScreen from './components/SplashScreen';
import GetDetails1 from './components/GetDetails1';
import GetDetails2 from './components/GetDetails2';
import GetDetails3 from './components/GetDetails3';
import HomePage from './components/HomePage';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<SplashScreen />} />
        <Route path="/details1" element={<GetDetails1 />} />
        <Route path="/details2" element={<GetDetails2 />} />
        <Route path="/details3" element={<GetDetails3 />} />
        <Route path="/home" element={<HomePage />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;