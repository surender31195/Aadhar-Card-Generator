import React from 'react';
import { useNavigate } from 'react-router-dom';

const GetDetails3 = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-white p-4">
      <h1>Details Step 3</h1>
      <button 
        onClick={() => navigate('/home')}
        className="bg-blue-500 text-white px-4 py-2 rounded"
      >
        Next
      </button>
    </div>
  );
};

export default GetDetails3;