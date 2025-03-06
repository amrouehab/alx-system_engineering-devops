#!/usr/bin/python3
"""
Module for recursively querying the Reddit API to count keywords in post titles
"""
import requests


def count_words(subreddit, word_list, after=None, word_counts=None):
    """
    Recursively queries the Reddit API, parses the titles of all hot articles,
    and prints a sorted count of given keywords.

    Args:
        subreddit (str): The name of the subreddit to query
        word_list (list): List of keywords to count
        after (str, optional): Pagination token for the next page
        word_counts (dict, optional): Dictionary to store the word counts

    Returns:
        None: Prints the sorted word counts
    """
    # Initialize the word_counts dictionary if not provided
    if word_counts is None:
        # Convert all words to lowercase and create a dictionary
        word_counts = {word.lower(): 0 for word in word_list}

    # Set the base URL for the Reddit API
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"

    # Add pagination parameter if provided
    params = {"after": after} if after else {}

    # Set a custom User-Agent to avoid Too Many Requests errors
    headers = {
        "User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/your_username)"
    }

    # Make the request to the Reddit API
    response = requests.get(
        url, headers=headers, params=params, allow_redirects=False
    )

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Parse the JSON response
        data = response.json().get("data", {})
        posts = data.get("children", [])
        after_token = data.get("after")

        # Process each post title
        for post in posts:
            title = post.get("data", {}).get("title", "").lower()
            # Split the title into words
            words = title.split()
            # Count the occurrences of each keyword
            for word in words:
                # Remove punctuation around the word
                clean_word = word.strip(".,!?:;\"'()[]{}")
                # Check if the cleaned word is in our word list
                for key in word_counts:
                    if clean_word == key.lower():
                        word_counts[key] += 1

        # If there are more pages, recursively fetch them
        if after_token:
            return count_words(subreddit, word_list, after_token, word_counts)
        else:
            # Print the sorted word counts
            # Remove words with 0 count
            filtered_counts = {k: v for k, v in word_counts.items() if v > 0}
            # Sort by count (descending) and then alphabetically
            sorted_counts = sorted(
                filtered_counts.items(),
                key=lambda x: (-x[1], x[0])
            )
            # Print the results
            for word, count in sorted_counts:
                print(f"{word.lower()}: {count}")
            return
    else:
        # Return without printing anything for invalid subreddits
        return
