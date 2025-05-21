import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import logo from '../assets/images/icons/logo.png';

const SplashScreen = () => {
  const navigate = useNavigate();

  useEffect(() => {
    const timer = setTimeout(() => {
      navigate('/details1');
    }, 2500);

    return () => clearTimeout(timer);
  }, [navigate]);

  return (
    <div className="min-h-screen bg-white flex items-center justify-center">
      <img src={logo} alt="Logo" className="w-48" />
    </div>
  );
};

export default SplashScreen;