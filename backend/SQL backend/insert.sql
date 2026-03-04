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


-- INSERTS FOR TIME SLOTS 
INSERT INTO Request_Time_Slots
(request_id, start_datetime, end_datetime, is_selected)
VALUES
-- Request 1 (Pending) – multiple proposals, none selected yet
(1, '2026-03-10 10:00:00', '2026-03-10 11:00:00', FALSE),
(1, '2026-03-11 14:00:00', '2026-03-11 15:00:00', FALSE),

-- Request 2 (Accepted) – one selected slot
(2, '2026-03-08 09:00:00', '2026-03-08 10:00:00', TRUE),
(2, '2026-03-09 16:00:00', '2026-03-09 17:00:00', FALSE),

-- Request 3 (Confirmed) – selected time locked
(3, '2026-03-06 13:00:00', '2026-03-06 14:30:00', TRUE),

-- Request 4 (Countered) – provider proposed new times
(4, '2026-03-12 11:00:00', '2026-03-12 12:00:00', FALSE),
(4, '2026-03-13 15:00:00', '2026-03-13 16:00:00', FALSE),

-- Request 5 (Pending) – three options
(5, '2026-03-14 10:00:00', '2026-03-14 11:00:00', FALSE),
(5, '2026-03-15 12:00:00', '2026-03-15 13:00:00', FALSE),
(5, '2026-03-16 09:00:00', '2026-03-16 10:00:00', FALSE),

-- Request 6 (Declined) – no selection
(6, '2026-03-07 14:00:00', '2026-03-07 15:00:00', FALSE),

-- Request 7 (Completed) – historical selected slot
(7, '2026-03-01 10:00:00', '2026-03-01 11:30:00', TRUE),

-- Request 8 (Cancelled) – proposed but cancelled
(8, '2026-03-02 13:00:00', '2026-03-02 14:00:00', FALSE),

-- Request 9 (Accepted) – one selected
(9, '2026-03-09 11:00:00', '2026-03-09 12:00:00', TRUE),

-- Request 10 (Confirmed) – selected
(10, '2026-03-05 15:00:00', '2026-03-05 16:00:00', TRUE);


-- INSERT FOR SESSIONS 
INSERT INTO Sessions
(request_id, start_datetime, end_datetime, status, is_active, cancelled_at)
VALUES
-- Request 2 (Accepted - upcoming session)
(2, '2026-03-08 09:00:00', '2026-03-08 10:00:00', 'Confirmed', TRUE, NULL),
-- Request 3 (Confirmed - upcoming session)
(3, '2026-03-06 13:00:00', '2026-03-06 14:30:00', 'Confirmed', TRUE, NULL),
-- Request 7 (Completed - past session)
(7, '2026-03-01 10:00:00', '2026-03-01 11:30:00', 'Completed', FALSE, NULL),
-- Request 9 (Accepted - upcoming)
(9, '2026-03-09 11:00:00', '2026-03-09 12:00:00', 'Confirmed', TRUE, NULL),
-- Request 10 (Confirmed but later cancelled)
(10, '2026-03-05 15:00:00', '2026-03-05 16:00:00', 'Cancelled', FALSE, '2026-03-04 18:00:00');


-- Reviews inserts 
INSERT INTO Reviews
(session_id, reviewer_id, rating, comment)
VALUES
-- Session 3 (Completed session - request 7)
-- Assume requester was User 1, provider was User 5
(3, 1, 5, 'Excellent session. Very clear explanations and helpful examples.'),
(3, 5, 4, 'Great student, well prepared and engaged throughout the lesson.'),
-- Optional: Add review for another completed session if you mark it completed later
-- Example if session 2 becomes completed
(2, 6, 4, 'Helpful session with good explanations.'),
(2, 4, 5, 'Student was punctual and easy to work with.');


-- CONVERSATIONS TABLE 
SELECT request_id FROM Lesson_Requests; - --check id from lesson requests 

INSERT INTO Conversations (request_id)
VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);

-- MESSAGES TABLE INSERTS
INSERT INTO Messages (conversation_id, sender_id, content, sent_at)
VALUES
-- Conversation 1 (Request 1: User 4 -> User 1)
(1, 4, 'Hi, I am interested in your Python lesson. Are you available this week?', '2026-03-03 10:15:00'),
(1, 1, 'Hi! Yes, I am available on Wednesday or Thursday afternoon.', '2026-03-03 10:18:00'),
(1, 4, 'Wednesday works for me. I have proposed a couple of times.', '2026-03-03 10:20:00'),
-- Conversation 2 (Request 2: User 6 -> User 4)
(2, 6, 'Hello, I need help with integration techniques.', '2026-03-02 09:05:00'),
(2, 4, 'Sure! I have accepted your 9am slot.', '2026-03-02 09:10:00'),
-- Conversation 3 (Request 3: User 8 -> User 7)
(3, 8, 'Hi, I would like feedback on my contract law essay.', '2026-03-01 12:30:00'),
(3, 7, 'Of course. Please upload it before the session.', '2026-03-01 12:45:00'),
(3, 8, 'Thanks, I have just sent it over.', '2026-03-01 13:00:00'),
-- Conversation 4 (Request 4: Countered)
(4, 2, 'I cannot make those times. Do you have availability later in the week?', '2026-03-03 14:00:00'),
(4, 3, 'No problem. I have countered with new proposed slots.', '2026-03-03 14:10:00'),
-- Conversation 5
(5, 5, 'Hi, I am looking for help with design patterns.', '2026-03-03 16:20:00'),
(5, 10, 'Great, I specialise in that area. Let me know which slot works.', '2026-03-03 16:25:00'),
-- Conversation 6 (Declined case)
(6, 9, 'Are you available for macroeconomics revision tomorrow?', '2026-03-02 18:00:00'),
(6, 8, 'Sorry, I am fully booked this week.', '2026-03-02 18:10:00'),
-- Conversation 7 (Completed session)
(7, 1, 'Thank you for the research methods session!', '2026-03-01 11:45:00'),
(7, 5, 'You are welcome! Good luck with your assignment.', '2026-03-01 11:50:00'),
-- Conversation 8 (Cancelled request)
(8, 3, 'Is the thermodynamics session still going ahead?', '2026-03-01 08:00:00'),
(8, 2, 'Unfortunately I need to cancel due to a timetable clash.', '2026-03-01 08:10:00'),
-- Conversation 9
(9, 7, 'Hi, I need help with anatomy revision.', '2026-03-03 09:00:00'),
(9, 9, 'Sure, I have confirmed the 11am session.', '2026-03-03 09:15:00'),
-- Conversation 10 (Cancelled session)
(10, 6, 'Looking forward to the lab report help session.', '2026-03-03 17:00:00'),
(10, 2, 'I may need to reschedule. I will confirm shortly.', '2026-03-03 17:10:00');


-- USER BLOCKS INSERTS
INSERT INTO User_Blocks (blocker_id, blocked_user_id)
VALUES
(3, 8),  -- User 3 blocked User 8
(5, 2),  -- User 5 blocked User 2
(7, 4),  -- User 7 blocked User 4
(9, 6),  -- User 9 blocked User 6
(1, 10), -- User 1 blocked User 10
(6, 3),  -- User 6 blocked User 3
(4, 9),  -- User 4 blocked User 9
(8, 1);  -- User 8 blocked User 1

-- INSERTS TO REPORTS 
INSERT INTO Reports (reporter_id, reported_user_id, reason, evidence, status)
VALUES
(4, 8, 'User repeatedly sent inappropriate messages during lesson request discussion.',
 'Screenshot of conversation showing offensive language.', 'Open'),
(2, 5, 'User failed to attend the scheduled session without prior notice.',
 'Chat log and session booking record.', 'Under Review'),
(7, 3, 'User provided misleading information about their skill level.',
 'Conversation screenshots and listing details.', 'Resolved'),
(6, 9, 'User used abusive language in chat.',
 'Screenshot of messages.', 'Open'),
(1, 10, 'User cancelled multiple sessions last minute without explanation.',
 'Session cancellation history.', 'Under Review'),
(5, 4, 'User spammed lesson requests repeatedly after being declined.',
 'Request logs showing repeated submissions.', 'Open'),
(3, 6, 'User behaved unprofessionally during the session.',
 'Session feedback and message logs.', 'Resolved');


 -- Availability inserts
 INSERT INTO Availability (user_id, day_of_week, start_time, end_time)
VALUES
-- User 1
(1, 1, '09:00', '12:00'),
(1, 3, '14:00', '17:00'),
-- User 2
(2, 2, '10:00', '13:00'),
(2, 4, '15:00', '18:00'),
-- User 3
(3, 1, '13:00', '16:00'),
(3, 5, '09:00', '11:00'),
-- User 4
(4, 3, '08:00', '10:00'),
(4, 6, '11:00', '14:00'),
-- User 5
(5, 2, '14:00', '17:00'),
(5, 4, '09:00', '12:00'),
-- User 6
(6, 1, '10:00', '12:00'),
(6, 5, '13:00', '16:00'),
-- User 7
(7, 3, '15:00', '18:00'),
(7, 6, '09:00', '11:00'),
-- User 8
(8, 2, '08:00', '11:00'),
(8, 4, '14:00', '17:00'),
-- User 9
(9, 1, '16:00', '19:00'),
(9, 5, '10:00', '13:00'),
-- User 10
(10, 3, '09:00', '12:00'),
(10, 4, '13:00', '15:00');

