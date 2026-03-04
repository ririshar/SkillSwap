--USERS TABLE 

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    university_id VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    course VARCHAR(150),
    profile_photo_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);



-- LISTINGS TABLE S
CREATE TABLE Listings (
    listing_id SERIAL PRIMARY KEY,
    owner_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    level VARCHAR(50) NOT NULL 
        CHECK (level IN ('Beginner', 'Intermediate', 'Advanced')),
    type VARCHAR(50) NOT NULL 
        CHECK (type IN ('Offered', 'Requested')),
    status VARCHAR(50) DEFAULT 'Active'
        CHECK (status IN ('Active', 'Inactive', 'Archived')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_listing_owner
        FOREIGN KEY (owner_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE
);



-- TAGS TABLE
CREATE TABLE Tags (
    tag_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);



-- LISTINGS TAGS 
CREATE TABLE Listing_Tags (
    listing_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,

    PRIMARY KEY (listing_id, tag_id),

    CONSTRAINT fk_listing
        FOREIGN KEY (listing_id)
        REFERENCES Listings(listing_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_tag
        FOREIGN KEY (tag_id)
        REFERENCES Tags(tag_id)
        ON DELETE CASCADE
);


---LESSON REQUEST TABLE 

CREATE TABLE Lesson_Requests (
    request_id SERIAL PRIMARY KEY,
    listing_id INTEGER NOT NULL,
    requester_id INTEGER NOT NULL,
    provider_id INTEGER NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,

    CONSTRAINT fk_request_listing
        FOREIGN KEY (listing_id)
        REFERENCES Listings(listing_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_request_requester
        FOREIGN KEY (requester_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_request_provider
        FOREIGN KEY (provider_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_request_status
        CHECK (status IN (
            'Pending',
            'Countered',
            'Accepted',
            'Confirmed',
            'Completed',
            'Declined',
            'Cancelled'
        ))
);





-- REQUEST TIME SLOT TABLE 

CREATE TABLE Request_Time_Slots (
    slot_id SERIAL PRIMARY KEY,
    request_id INTEGER NOT NULL,
    start_datetime TIMESTAMP NOT NULL,
    end_datetime TIMESTAMP NOT NULL,
    is_selected BOOLEAN DEFAULT FALSE,

    CONSTRAINT fk_slot_request
        FOREIGN KEY (request_id)
        REFERENCES Lesson_Requests(request_id)
        ON DELETE CASCADE
);

-- Session table 
CREATE TABLE Sessions (
    session_id SERIAL PRIMARY KEY,
    request_id INTEGER UNIQUE NOT NULL,
    start_datetime TIMESTAMP NOT NULL,
    end_datetime TIMESTAMP NOT NULL,
    status VARCHAR(50) DEFAULT 'Confirmed',
    is_active BOOLEAN DEFAULT TRUE,
    cancelled_at TIMESTAMP,

    CONSTRAINT fk_session_request
        FOREIGN KEY (request_id)
        REFERENCES Lesson_Requests(request_id)
        ON DELETE CASCADE
);

-- REVIEW table 
CREATE TABLE Reviews (
    review_id SERIAL PRIMARY KEY,
    session_id INTEGER NOT NULL,
    reviewer_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_review_session
        FOREIGN KEY (session_id)
        REFERENCES Sessions(session_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_review_user
        FOREIGN KEY (reviewer_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE
);

-- CONVERSATIONS TABLE 
CREATE TABLE Conversations (
    conversation_id SERIAL PRIMARY KEY,
    request_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_conversation_request
        FOREIGN KEY (request_id)
        REFERENCES Lesson_Requests(request_id)
        ON DELETE CASCADE
);

-- Messages Table 
CREATE TABLE Messages (
    message_id SERIAL PRIMARY KEY,
    conversation_id INTEGER NOT NULL,
    sender_id INTEGER NOT NULL,
    content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_message_conversation
        FOREIGN KEY (conversation_id)
        REFERENCES Conversations(conversation_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_message_sender
        FOREIGN KEY (sender_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE
);
-- Blocked table for user 
CREATE TABLE User_Blocks (
    block_id SERIAL PRIMARY KEY,
    blocker_id INTEGER NOT NULL,
    blocked_user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_blocker
        FOREIGN KEY (blocker_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_blocked
        FOREIGN KEY (blocked_user_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT unique_block UNIQUE (blocker_id, blocked_user_id)
);

-- Report table 
CREATE TABLE Reports (
    report_id SERIAL PRIMARY KEY,
    reporter_id INTEGER NOT NULL,
    reported_user_id INTEGER NOT NULL,
    reason TEXT NOT NULL,
    evidence TEXT,
    status VARCHAR(50) DEFAULT 'Open',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_reporter
        FOREIGN KEY (reporter_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_reported
        FOREIGN KEY (reported_user_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE
);

-- Availability 
CREATE TABLE Availability (
    availability_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    day_of_week INTEGER NOT NULL CHECK (day_of_week BETWEEN 0 AND 6),
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,

    CONSTRAINT fk_availability_user
        FOREIGN KEY (user_id)
        REFERENCES Users(user_id)
        ON DELETE CASCADE
);



