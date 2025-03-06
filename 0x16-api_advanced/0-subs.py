#!/usr/bin/python3
"""
Module for querying the Reddit API to get subscriber counts of subreddits
"""
import requests


def number_of_subscribers(subreddit):
    """
    Queries the Reddit API and returns the number of subscribers
    for a given subreddit.

    Args:
        subreddit (str): The name of the subreddit to query

    Returns:
        int: The number of subscribers if the subreddit is valid, 0 otherwise
    """
    # Reddit API URL for getting subreddit information
    url = f"https://www.reddit.com/r/{subreddit}/about.json"

    # Set a custom User-Agent to avoid Too Many Requests errors
    headers = {
        "User-Agent": "linux:0x16.api.advanced:v1.0.0 (by /u/your_username)"
    }

    # Make the request to the Reddit API
    response = requests.get(url, headers=headers, allow_redirects=False)

    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        # Parse the JSON response and extract the subscribers count
        data = response.json()
        return data.get("data", {}).get("subscribers", 0)
    else:
        # Return 0 for invalid subreddits or any other error
        return 0
