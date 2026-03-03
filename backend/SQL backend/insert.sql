INSERT INTO Users
(university_id, email, first_name, surname, course, profile_photo_url)
VALUES
('up1234567', 'alice.johnson@myport.ac.uk', 'Alice', 'Johnson', 'Computer Science', 'https://example.com/photos/alice.jpg'),
('up2134568', 'michael.smith@myport.ac.uk', 'Michael', 'Smith', 'Mechanical Engineering', 'https://example.com/photos/michael.jpg'),
('up1234569', 'sophia.brown@myport.ac.uk', 'Sophia', 'Brown', 'Business Management', 'https://example.com/photos/sophia.jpg'),
('up1234570', 'daniel.williams@myport.ac.uk', 'Daniel', 'Williams', 'Mathematics', 'https://example.com/photos/daniel.jpg'),
('up1234571', 'emma.jones@myport.ac.uk', 'Emma', 'Jones', 'Psychology', 'https://example.com/photos/emma.jpg'),
('up1234572', 'oliver.taylor@myport.ac.uk', 'Oliver', 'Taylor', 'Physics', 'https://example.com/photos/oliver.jpg'),
('up1234573', 'ava.thomas@myport.ac.uk', 'Ava', 'Thomas', 'Law', 'https://example.com/photos/ava.jpg'),
('up1234574', 'noah.white@myport.ac.uk', 'Noah', 'White', 'Economics', 'https://example.com/photos/noah.jpg'),
('up1234575', 'mia.harris@myport.ac.uk', 'Mia', 'Harris', 'Biomedical Science', 'https://example.com/photos/mia.jpg'),
('up1234576', 'liam.martin@myport.ac.uk', 'Liam', 'Martin', 'Software Engineering', 'https://example.com/photos/liam.jpg');

INSERT INTO Listings
(owner_id, title, description, level, type, status)
VALUES
(1, 'Introduction to Python Programming',
'Learn the basics of Python including variables, loops, and functions. Ideal for students new to programming.',
'Beginner', 'Offered', 'Active'),
(2, 'Advanced Thermodynamics Problem Solving',
'Help with complex thermodynamics equations and exam preparation for engineering students.',
'Advanced', 'Offered', 'Active'),
(3, 'Business Presentation Skills Coaching',
'Improve your confidence and structure when delivering presentations.',
'Intermediate', 'Offered', 'Active'),
(4, 'Calculus I Revision Sessions',
'Revision support for differentiation, integration, and exam-style questions.',
'Beginner', 'Offered', 'Active'),
(5, 'Psychology Research Methods Support',
'Guidance on research design, data collection, and SPSS basics.',
'Intermediate', 'Offered', 'Active'),
(6, 'Physics Lab Report Assistance',
'Support in structuring and improving lab reports for physics modules.',
'Beginner', 'Requested', 'Active'),
(7, 'Contract Law Essay Feedback',
'Detailed feedback on law essays including structure and referencing.',
'Advanced', 'Offered', 'Active'),
(8, 'Macroeconomics Exam Preparation',
'Exam-focused sessions covering inflation, GDP, and fiscal policy.',
'Intermediate', 'Offered', 'Active'),
(9, 'Biomedical Science Anatomy Help',
'Support with understanding anatomical systems and exam revision.',
'Beginner', 'Requested', 'Active'),
(10, 'Software Engineering Design Patterns',
'In-depth explanation of common design patterns and practical examples.',
'Advanced', 'Offered', 'Active');




INSERT INTO Tags (name) VALUES
('Programming'),
('Python'),
('Java'),
('C++'),
('Web Development'),
('HTML'),
('CSS'),
('JavaScript'),
('Data Analysis'),
('Machine Learning'),
('Software Engineering'),
('Design Patterns'),
('Mathematics'),
('Algebra'),
('Calculus'),
('Statistics'),
('Physics'),
('Engineering'),
('Law'),
('Contract Law'),
('Essay Writing'),
('Referencing'),
('Economics'),
('Macroeconomics'),
('Microeconomics'),
('Psychology'),
('Research Methods'),
('SPSS'),
('Biomedical Science'),
('Anatomy'),
('Presentation Skills'),
('Public Speaking'),
('Exam Preparation'),
('Revision Support'),
('Lab Reports'),
('Dissertation Support');

INSERT INTO Listing_Tags (listing_id, tag_id) VALUES
-- Listing 1: Introduction to Python Programming
(1, 1),  -- Programming
(1, 2),  -- Python
(1, 9),  -- Data Analysis

-- Listing 2: Advanced Thermodynamics
(2, 18), -- Engineering
(2, 17), -- Physics
(2, 33), -- Exam Preparation

-- Listing 3: Business Presentation Skills
(3, 30), -- Presentation Skills
(3, 31), -- Public Speaking

-- Listing 4: Calculus Revision
(4, 13), -- Mathematics
(4, 15), -- Calculus
(4, 33), -- Exam Preparation
(4, 34), -- Revision Support

-- Listing 5: Psychology Research Methods
(5, 26), -- Psychology
(5, 27), -- Research Methods
(5, 28), -- SPSS

-- Listing 6: Physics Lab Report Assistance
(6, 17), -- Physics
(6, 35), -- Lab Reports

-- Listing 7: Contract Law Essay Feedback
(7, 19), -- Law
(7, 20), -- Contract Law
(7, 21), -- Essay Writing
(7, 22), -- Referencing

-- Listing 8: Macroeconomics Exam Prep
(8, 23), -- Economics
(8, 24), -- Macroeconomics
(8, 33), -- Exam Preparation

-- Listing 9: Biomedical Anatomy Help
(9, 29), -- Biomedical Science
(9, 30), -- Anatomy

-- Listing 10: Software Engineering Design Patterns
(10, 11), -- Software Engineering
(10, 12), -- Design Patterns
(10, 1);  -- Programming

INSERT INTO Lesson_Requests
(listing_id, requester_id, provider_id, status, expires_at)
VALUES
(1, 4, 1, 'Pending', NOW() + INTERVAL '3 days'),
(4, 6, 4, 'Accepted', NOW() + INTERVAL '2 days'),
(7, 8, 7, 'Confirmed', NOW() + INTERVAL '1 day'),
(3, 2, 3, 'Countered', NOW() + INTERVAL '3 days'),
(10, 5, 10, 'Pending', NOW() + INTERVAL '4 days'),
(8, 9, 8, 'Declined', NOW() + INTERVAL '2 days'),
(5, 1, 5, 'Completed', NOW() - INTERVAL '2 days'),
(2, 3, 2, 'Cancelled', NOW() - INTERVAL '1 day'),
(9, 7, 9, 'Accepted', NOW() + INTERVAL '2 days'),
(6, 2, 6, 'Confirmed', NOW() + INTERVAL '1 day');




