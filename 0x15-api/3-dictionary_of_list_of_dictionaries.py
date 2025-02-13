#!/usr/bin/python3
"""
Script to export TODO list data for all employees to a JSON file.
"""

import json
import requests

def fetch_all_employee_data():
    """Fetch TODO list data for all employees."""
    base_url = "https://jsonplaceholder.typicode.com"
    users_url = f"{base_url}/users"
    todos_url = f"{base_url}/todos"

    # Fetch all users
    users_response = requests.get(users_url)
    if users_response.status_code != 200:
        print("Error: Unable to fetch users data")
        sys.exit(1)
    users_data = users_response.json()

    # Fetch all TODOs
    todos_response = requests.get(todos_url)
    if todos_response.status_code != 200:
        print("Error: Unable to fetch TODOs data")
        sys.exit(1)
    todos_data = todos_response.json()

    return users_data, todos_data

def export_all_to_json(users, todos):
    """Export TODO list data for all employees to a JSON file."""
    filename = "todo_all_employees.json"
    data = {}

    for user in users:
        user_id = user.get("id")
        username = user.get("username")
        user_tasks = [task for task in todos if task.get("userId") == user_id]
        tasks = [{"username": username, "task": task.get("title"), "completed": task.get("completed")} for task in user_tasks]
        data[user_id] = tasks

    with open(filename, mode="w") as file:
        json.dump(data, file, indent=4)

if __name__ == "__main__":
    users_data, todos_data = fetch_all_employee_data()
    export_all_to_json(users_data, todos_data)
