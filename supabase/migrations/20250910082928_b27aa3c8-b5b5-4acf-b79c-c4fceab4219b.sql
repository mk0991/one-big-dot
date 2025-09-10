-- Insert sample rooms with existing images
INSERT INTO public.rooms (name, description, capacity, size_sqm, price_nad, amenities, images, is_featured, is_available) VALUES
('Executive Suite', 'Spacious luxury suite with separate living area, perfect for business travelers and special occasions. Features premium amenities and modern furnishings.', 2, 45, 180000, ARRAY['Air Conditioning', 'WiFi', 'TV', 'Mini Fridge', 'Room Service', 'Work Desk', 'Balcony', 'Coffee Maker'], ARRAY['/room-executive.jpg', '/room-balcony.jpg'], true, true),

('Luxury Family Suite', 'Comfortable family accommodation with space for up to 4 guests. Includes separate sleeping areas and family-friendly amenities.', 4, 55, 220000, ARRAY['Air Conditioning', 'WiFi', 'TV', 'Mini Fridge', 'Room Service', 'Family Bathroom', 'Living Area'], ARRAY['/room-family.jpg', '/suite-room.jpg'], true, true),

('Deluxe Room', 'Well-appointed room with modern amenities and comfortable bedding. Perfect for couples or business travelers.', 2, 30, 140000, ARRAY['Air Conditioning', 'WiFi', 'TV', 'Mini Fridge', 'Private Bathroom', 'Work Desk'], ARRAY['/room-luxury-suite.jpg', '/room-bathroom.jpg'], false, true),

('Standard Double Room', 'Comfortable and affordable accommodation with essential amenities for a pleasant stay.', 2, 25, 120000, ARRAY['Air Conditioning', 'WiFi', 'TV', 'Private Bathroom'], ARRAY['/room-executive.jpg'], false, true);

-- Insert sample activities
INSERT INTO public.activities (name, description, duration, capacity, difficulty_level, price_nad, includes, images, is_featured, category) VALUES
('Safari Game Drive', 'Experience the thrill of African wildlife on a guided game drive through local conservancies. Spot elephants, lions, giraffes and more in their natural habitat.', '4 hours', 8, 'Easy', 85000, ARRAY['Professional Guide', 'Transportation', 'Refreshments', 'Binoculars'], ARRAY['/safari-activity.jpg', '/gallery-wildlife.jpg'], true, 'Safari'),

('Cultural Village Tour', 'Immerse yourself in local culture with visits to traditional villages. Learn about customs, crafts, and daily life of the local communities.', '3 hours', 12, 'Easy', 45000, ARRAY['Local Guide', 'Transportation', 'Cultural Demonstrations', 'Light Refreshments'], ARRAY['/gallery-guesthouse.jpg'], true, 'Cultural'),

('Desert Excursion', 'Explore the stunning desert landscapes surrounding Rundu. Experience the beauty of Namibian desert ecosystems and unique flora.', '6 hours', 6, 'Moderate', 120000, ARRAY['4WD Transportation', 'Professional Guide', 'Lunch', 'Water', 'Sun Protection'], ARRAY['/gallery-desert.jpg'], false, 'Adventure'),

('Okavango River Cruise', 'Peaceful boat cruise along the Okavango River. Perfect for bird watching and enjoying the serene waterways.', '2 hours', 15, 'Easy', 65000, ARRAY['Boat Transport', 'Guide', 'Life Jackets', 'Refreshments'], ARRAY['/gallery-wildlife.jpg'], false, 'Water Sports');

-- Insert gallery items
INSERT INTO public.gallery (title, description, image_url, category, sort_order) VALUES
('Guesthouse Exterior', 'Beautiful view of Beaufort Guesthouse surrounded by lush gardens', '/gallery-guesthouse.jpg', 'property', 1),
('Wildlife Safari', 'Magnificent wildlife encounters during our guided safari tours', '/gallery-wildlife.jpg', 'activities', 2),
('Desert Landscapes', 'Stunning desert vistas near Rundu, perfect for exploration', '/gallery-desert.jpg', 'nature', 3),
('Restaurant Dining', 'Elegant dining experience at our on-site restaurant', '/restaurant.jpg', 'dining', 4);

-- Insert sample ratings
INSERT INTO public.ratings (rating_type, room_id, rating, review_text, guest_name) VALUES
('room', (SELECT id FROM public.rooms WHERE name = 'Executive Suite' LIMIT 1), 5, 'Absolutely wonderful stay! The suite was spacious and beautifully appointed. Perfect for our anniversary.', 'Sarah Johnson'),
('room', (SELECT id FROM public.rooms WHERE name = 'Executive Suite' LIMIT 1), 4, 'Great room with excellent amenities. The balcony view was fantastic.', 'Michael Peters'),
('room', (SELECT id FROM public.rooms WHERE name = 'Luxury Family Suite' LIMIT 1), 5, 'Perfect for our family vacation. Kids loved the space and we appreciated the family-friendly setup.', 'David Williams'),
('room', (SELECT id FROM public.rooms WHERE name = 'Deluxe Room' LIMIT 1), 4, 'Comfortable room with everything we needed. Good value for money.', 'Emma Thompson');

INSERT INTO public.ratings (rating_type, activity_id, rating, review_text, guest_name) VALUES
('activity', (SELECT id FROM public.activities WHERE name = 'Safari Game Drive' LIMIT 1), 5, 'Incredible experience! Saw elephants, lions, and so much more. Our guide was fantastic.', 'Robert Smith'),
('activity', (SELECT id FROM public.activities WHERE name = 'Safari Game Drive' LIMIT 1), 5, 'Best safari experience ever! Highly recommend for wildlife enthusiasts.', 'Lisa Anderson'),
('activity', (SELECT id FROM public.activities WHERE name = 'Cultural Village Tour' LIMIT 1), 4, 'Very educational and eye-opening. Great way to learn about local culture.', 'James Wilson'),
('activity', (SELECT id FROM public.activities WHERE name = 'Okavango River Cruise' LIMIT 1), 4, 'Peaceful and relaxing. Perfect for bird watching and photography.', 'Maria Garcia');