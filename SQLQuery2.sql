CREATE DATABASE SocialMediaPlatform;
USE SocialMediaPlatform;
----------$[TASK_A]------------
CREATE TABLE Users(
userID INT IDENTITY PRIMARY KEY,
userName NVARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
dob DATE NOT NULL,
 Gender NVARCHAR(50) NOT NULL,
 joinDate DATETIME DEFAULT GETUTCDATE()
);
CREATE TABLE Posts(
postID INT IDENTITY PRIMARY KEY,
content NVARCHAR(MAX) NOT NULL,
postDate DATETIME DEFAULT GETUTCDATE(),
visability NVARCHAR(50) NOT NULL,
userID INT NOT NULL,
FOREIGN  KEY (userID) REFERENCES Users(userID) 
);
CREATE TABLE UserInteractPost(
userID INT NOT NULL,
postID INT NOT NULL,
 PRIMARY KEY (userID, postID),
FOREIGN KEY (userID) REFERENCES Users(userID),
FOREIGN KEY (postID) REFERENCES Posts(postID),
);
CREATE TABLE Comments(
commentID INT IDENTITY PRIMARY KEY,
commentDate DATETIME DEFAULT GETUTCDATE(),
content NVARCHAR(MAX) NOT NULL,
userID INT NOT NULL,
postID INT NOT NULL,
FOREIGN KEY (userID) REFERENCES Users(userID),
FOREIGN KEY (postID) REFERENCES Posts(postID)
);
CREATE TABLE Interactions(
interactionID INT IDENTITY PRIMARY KEY,
type NVARCHAR(50) NOT NULL,
interactionDate DATETIME DEFAULT GETUTCDATE(),
userID INT NOT NULL,
postID INT NOT NULL,
FOREIGN KEY (userID) REFERENCES Users(userID),
FOREIGN KEY (postID) REFERENCES Posts(postID)
);

INSERT INTO Users (userName, email, dob, Gender) 
VALUES
('Sara Ali', 'sara@example.com', '1998-08-20', 'Female'),
('Mohamed Sami', 'mohamed@example.com', '2000-02-10', 'Male'),
('Nour Hassan', 'nour@example.com', '1992-12-05', 'Female');

INSERT INTO Posts (content, visability, userID) 
VALUES 
('Hello world! This is my first post.', 'Public', 1),
('Having a great day! #blessed', 'Private', 2),
('Anyone up for a coding challenge?', 'Public', 3);
INSERT INTO Comments (content, userID, postID) 
VALUES
('Great post!', 1, 2),
('I love this topic!', 2, 3),
('Amazing!', 3, 1);
INSERT INTO Interactions (type, userID, postID) 
VALUES
('Like', 1, 2),
('Share', 3, 1),
('Comment', 2, 3);

--SELECT *FROM Users;
--SELECT *FROM Posts;
--SELECT *FROM Interactions;

--&[DELETE TABLE Users]----
DELETE FROM Comments WHERE userID IN(SELECT userID FROM Users);
DELETE FROM Interactions WHERE userID IN (SELECT userID FROM Users);
DELETE FROM Posts WHERE userID in (SELECT userID FROM Users); 
DELETE FROM Users
--$[DROP DATABASE]---
USE master;
DROP DATABASE SocialMediaPlatform;

