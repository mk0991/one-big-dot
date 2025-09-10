const Index = () => {
  return (
    <div className="flex min-h-screen items-center justify-center bg-gradient-bg overflow-hidden">
      <div className="text-center">
        <h1 
          className="text-[20rem] md:text-[25rem] lg:text-[30rem] font-bold leading-none select-none transition-smooth hover:number-glow text-shadow-number cursor-default"
          style={{ 
            fontFamily: "'SF Pro Display', -apple-system, BlinkMacSystemFont, sans-serif",
            fontWeight: 700,
            letterSpacing: '-0.05em'
          }}
        >
          1
        </h1>
      </div>
    </div>
  );
};

export default Index;
