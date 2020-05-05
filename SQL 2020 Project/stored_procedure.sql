-- Get the total number of tweets from a city between a date range.  This would be useful for someone who wants to look at the changes in the number of tweets sent over a period of time.
-- The format allows for getting tweet counts by hour, day, month, year, etc... The amounts can then be analyzed further to determine the percent change in activity over whatever time period the analyst chooses.

DELIMITER $$

DROP PROCEDURE IF EXISTS getTweetsCount$$

CREATE PROCEDURE getTweetsCount(inTweetDateStart DATETIME, inTweetDateEnd DATETIME, inCityName VARCHAR(255), OUT outTweetCount INT)
BEGIN
	SET @tweetDateStart := inTweetDateStart;
    SET @tweetDateEnd := inTweetDateEnd;
    SET @cityName := inCityName;
    
    SELECT COUNT(*) INTO outTweetCount
    FROM tweets
    JOIN city
		ON tweets.city_id = city.city_id
	WHERE fixed_date BETWEEN @tweetDateStart AND @tweetDateEnd
		AND city_name = @cityName;

END$$

DELIMITER ;

-- There were 24 tweets from New York on 4/11
CALL getTweetsCount('2020-04-11', '2020-04-11 23:59:59', 'New York', @tweetsCount);
SELECT @tweetsCount;