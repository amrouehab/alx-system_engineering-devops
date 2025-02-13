#!/usr/bin/python3
"""
Script to export TODO list data for a given employee ID to a JSON file.
"""

import json
import requests
import sys

def fetch_employee_data(employee_id):
    """Fetch employee and TODO data from the API."""
    base_url = "https://jsonplaceholder.typicode.com"
    user_url = f"{base_url}/users/{employee_id}"
    todos_url = f"{base_url}/users/{employee_id}/todos"

    # Fetch user data
    user_response = requests.get(user_url)
    if user_response.status_code != 200:
        print(f"Error: Unable to fetch user data for ID {employee_id}")
        sys.exit(1)
    user_data = user_response.json()

    # Fetch TODO data
    todos_response = requests.get(todos_url)
    if todos_response.status_code != 200:
        print(f"Error: Unable to fetch TODO data for ID {employee_id}")
        sys.exit(1)
    todos_data = todos_response.json()

    return user_data, todos_data

def export_to_json(employee_id, username, todos):
    """Export TODO list data to a JSON file."""
    filename = f"{employee_id}.json"
    tasks = [{"task": task.get("title"), "completed": task.get("completed"), "username": username} for task in todos]
    data = {employee_id: tasks}

    with open(filename, mode="w") as file:
        json.dump(data, file, indent=4)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 2-export_to_JSON.py <employee_id>")
        sys.exit(1)

    employee_id = int(sys.argv[1])
    user_data, todos_data = fetch_employee_data(employee_id)
    export_to_json(employee_id, user_data.get("username"), todos_data)
