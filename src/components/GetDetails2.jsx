import React from 'react';
import { useNavigate } from 'react-router-dom';

const GetDetails2 = () => {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-white p-4">
      <h1>Details Step 2</h1>
      <button 
        onClick={() => navigate('/details3')}
        className="bg-blue-500 text-white px-4 py-2 rounded"
      >
        Next
      </button>
    </div>
  );
};

export default GetDetails2;