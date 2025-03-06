#!/usr/bin/python3
"""
Module for querying the Reddit API to get the top 10 hot posts
"""
import requests


def top_ten(subreddit):
    """
    Queries the Reddit API and prints the titles of the first 10 hot posts
    for a given subreddit.

    Args:
        subreddit (str): The name of the subreddit to query

    Returns:
        None: Prints the titles of the posts or None if invalid subreddit
    """
    # Reddit API URL for getting hot posts
    url = f"https://www.reddit.com/r/{subreddit}/hot.json?limit=10"

    # Set a custom User-Agent to avoid Too Many Requests errors
    headers = {
        "User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/your_username)"
    }

    # Make the request to the Reddit API
    response = requests.get(url, headers=headers, allow_redirects=False)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Parse the JSON response
        data = response.json().get("data", {}).get("children", [])
        # Print the titles of the first 10 hot posts
        for post in data:
            print(post.get("data", {}).get("title", ""))
    else:
        # Print None for invalid subreddits
        print(None)
