const CustomTextField1 = ({ 
  label, 
  value, 
  onChange, 
  type = "text",
  required = false,
  error = false,
  helperText = "",
  prefix,
  suffix
}) => {
  return (
    <div className="mb-4">
      <div className="relative">
        {prefix && <span className="absolute left-3 top-1/2 transform -translate-y-1/2">{prefix}</span>}
        <input
          type={type}
          value={value}
          onChange={onChange}
          className={`w-full p-2 border-b-2 ${error ? 'border-red-500' : 'border-gray-300'} focus:border-blue-500 outline-none ${prefix ? 'pl-10' : ''} ${suffix ? 'pr-10' : ''}`}
          placeholder={label}
          required={required}
        />
        {suffix && <span className="absolute right-3 top-1/2 transform -translate-y-1/2">{suffix}</span>}
      </div>
      {error && <p className="text-red-500 text-sm mt-1">{helperText}</p>}
    </div>
  );
};

const CustomTextField2 = ({ 
  label, 
  value, 
  onChange, 
  type = "text",
  required = false,
  error = false,
  helperText = "",
  prefix,
  suffix
}) => {
  return (
    <div className="mb-4">
      <div className="relative">
        {prefix && <span className="absolute left-3 top-1/2 transform -translate-y-1/2">{prefix}</span>}
        <input
          type={type}
          value={value}
          onChange={onChange}
          className={`w-full p-4 border-2 rounded-full ${error ? 'border-red-500' : 'border-gray-300'} focus:border-blue-500 outline-none ${prefix ? 'pl-10' : ''} ${suffix ? 'pr-10' : ''}`}
          placeholder={label}
          required={required}
        />
        {suffix && <span className="absolute right-3 top-1/2 transform -translate-y-1/2">{suffix}</span>}
      </div>
      {error && <p className="text-red-500 text-sm mt-1">{helperText}</p>}
    </div>
  );
};

export { CustomTextField1, CustomTextField2 };