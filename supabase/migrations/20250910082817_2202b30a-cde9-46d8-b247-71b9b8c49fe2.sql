-- Fix security warnings by setting search_path on functions
CREATE OR REPLACE FUNCTION public.get_room_average_rating(room_uuid UUID)
RETURNS DECIMAL 
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN (
    SELECT ROUND(AVG(rating::DECIMAL), 1)
    FROM public.ratings
    WHERE room_id = room_uuid
  );
END;
$$;

CREATE OR REPLACE FUNCTION public.get_activity_average_rating(activity_uuid UUID)
RETURNS DECIMAL 
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN (
    SELECT ROUND(AVG(rating::DECIMAL), 1)
    FROM public.ratings
    WHERE activity_id = activity_uuid
  );
END;
$$;