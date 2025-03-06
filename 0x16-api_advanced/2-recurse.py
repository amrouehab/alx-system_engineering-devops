#!/usr/bin/python3
"""
Module for recursively querying the Reddit API to get all hot posts
"""
import requests


def recurse(subreddit, hot_list=None, after=None):
    """
    Recursively queries the Reddit API and returns a list containing the titles
    of all hot articles for a given subreddit.

    Args:
        subreddit (str): The name of the subreddit to query
        hot_list (list, optional): List to store the post titles
        after (str, optional): Pagination token for the next page

    Returns:
        list: List of all hot post titles if the subreddit is valid, None otherwise
    """
    # Initialize the hot_list if not provided
    if hot_list is None:
        hot_list = []

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

        # Add the titles of the current page posts to the hot_list
        for post in posts:
            hot_list.append(post.get("data", {}).get("title"))

        # If there are more pages, recursively fetch them
        if after_token:
            return recurse(subreddit, hot_list, after_token)
        
        # Return the complete list of hot post titles
        return hot_list
    else:
        # Return None for invalid subreddits
        return None
