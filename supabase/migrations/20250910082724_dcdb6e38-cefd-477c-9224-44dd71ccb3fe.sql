-- Create rooms table
CREATE TABLE public.rooms (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  capacity INTEGER NOT NULL DEFAULT 2,
  size_sqm INTEGER,
  price_nad INTEGER NOT NULL, -- Price in cents
  amenities TEXT[] DEFAULT '{}',
  images TEXT[] DEFAULT '{}',
  is_featured BOOLEAN DEFAULT false,
  is_available BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create activities table
CREATE TABLE public.activities (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  duration TEXT,
  capacity INTEGER NOT NULL DEFAULT 10,
  difficulty_level TEXT DEFAULT 'Easy',
  price_nad INTEGER NOT NULL, -- Price in cents
  includes TEXT[] DEFAULT '{}',
  images TEXT[] DEFAULT '{}',
  is_featured BOOLEAN DEFAULT false,
  is_available BOOLEAN DEFAULT true,
  category TEXT DEFAULT 'Adventure',
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create gallery table
CREATE TABLE public.gallery (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  image_url TEXT NOT NULL,
  category TEXT DEFAULT 'general',
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create ratings table
CREATE TABLE public.ratings (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  rating_type TEXT NOT NULL CHECK (rating_type IN ('room', 'activity')),
  room_id UUID REFERENCES public.rooms(id) ON DELETE CASCADE,
  activity_id UUID REFERENCES public.activities(id) ON DELETE CASCADE,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  review_text TEXT,
  guest_name TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Create bookings table
CREATE TABLE public.bookings (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  guest_name TEXT NOT NULL,
  guest_email TEXT NOT NULL,
  guest_phone TEXT,
  booking_type TEXT NOT NULL CHECK (booking_type IN ('room', 'activity')),
  room_id UUID REFERENCES public.rooms(id) ON DELETE CASCADE,
  activity_id UUID REFERENCES public.activities(id) ON DELETE CASCADE,
  check_in DATE,
  check_out DATE,
  activity_date DATE,
  guests INTEGER NOT NULL DEFAULT 1,
  total_amount INTEGER NOT NULL, -- Amount in cents
  payment_status TEXT DEFAULT 'pending' CHECK (payment_status IN ('pending', 'paid', 'cancelled')),
  special_requests TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE public.rooms ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.gallery ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ratings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access (since no auth is implemented)
CREATE POLICY "Anyone can view rooms" ON public.rooms FOR SELECT USING (true);
CREATE POLICY "Anyone can view activities" ON public.activities FOR SELECT USING (true);
CREATE POLICY "Anyone can view gallery" ON public.gallery FOR SELECT USING (true);
CREATE POLICY "Anyone can view ratings" ON public.ratings FOR SELECT USING (true);
CREATE POLICY "Anyone can insert bookings" ON public.bookings FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can view bookings" ON public.bookings FOR SELECT USING (true);
CREATE POLICY "Anyone can insert ratings" ON public.ratings FOR INSERT WITH CHECK (true);

-- Create function to get room average rating
CREATE OR REPLACE FUNCTION public.get_room_average_rating(room_uuid UUID)
RETURNS DECIMAL AS $$
BEGIN
  RETURN (
    SELECT ROUND(AVG(rating::DECIMAL), 1)
    FROM public.ratings
    WHERE room_id = room_uuid
  );
END;
$$ LANGUAGE plpgsql;

-- Create function to get activity average rating
CREATE OR REPLACE FUNCTION public.get_activity_average_rating(activity_uuid UUID)
RETURNS DECIMAL AS $$
BEGIN
  RETURN (
    SELECT ROUND(AVG(rating::DECIMAL), 1)
    FROM public.ratings
    WHERE activity_id = activity_uuid
  );
END;
$$ LANGUAGE plpgsql;

-- Create trigger function for updating timestamps
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SET search_path = public;

-- Create triggers for automatic timestamp updates
CREATE TRIGGER update_rooms_updated_at
  BEFORE UPDATE ON public.rooms
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();

CREATE TRIGGER update_activities_updated_at
  BEFORE UPDATE ON public.activities
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at_column();